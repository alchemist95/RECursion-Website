class QuestionsController < ApplicationController
  before_action :authenticate, only: [:new, :create]
  helper_method :sort_column, :sort_direction
  before_filter :set_cache_headers


  def new
    if current_user && current_user.nickname.blank?
      flash[:notice] = "Please Complete your profile"
      redirect_to profile_update_path
    else
     @question = Question.new
    end
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @forum_page = true
    @question = Question.find(params[:id])
    if User.find(@question.user_id).nickname.blank? || (current_user && current_user.nickname.blank?)
      flash[:notice] = "Please complete your profile"
      redirect_to root_url
    else
      @tags = @question.tags
      @answer = Answer.new
      @unsorted_answers = @question.answers
      @answers = @unsorted_answers.sort_by {|x| [-x.upvote_count, x.created_at] }
      @users = @unsorted_answers.group(:user_id).pluck(:user_id)
      @comments = @question.comments.order(created_at: :desc)
    end
  end

  def tagged_questions

    @tag = params[:tag]

    if sort_column == 'Answers'
      @questions = Question.tagged_with(@tag).sort_by(&:answer_count)
    elsif sort_column == 'Date'
      @questions = Question.tagged_with(@tag).order('created_at')
    else
      @questions = Question.tagged_with(@tag).sort_by(&:follow_count)
    end

    if sort_direction == 'desc'
      @questions = @questions.reverse
    end

    @questions = @questions.paginate(page: params[:page], per_page: 15)

  end

  def submit_answer

    answer = Answer.new(answer_params)
    answer.user_id = current_user.id
    answer.question_id = params[:id]
    answer.save!
    redirect_to question_path

  end

  def edit_answer

    answer = Answer.find(params['id'])
    answer.update(description: params['description'])
    answer.save!

  end

  def edit_tag_name

    old_tag = params["old_tag"].to_i
    puts old_tag
    new_tag = params["new_tag"].strip.downcase

    old_tag_id = Tag.where(id: old_tag).pluck(:id)[0]
    tagging = Tagging.find(Tagging.where(question_id: params[:q_id].to_i, tag_id: old_tag_id).pluck(:id)[0])

    Tag.where(name: new_tag).first_or_create!
    new_tag_id = Tag.where(name: new_tag).pluck(:id)[0]
    
    tagging.tag_id = new_tag_id
    tagging.save! 

  end

  def add_tag

    new_tag = params["name"].strip.downcase
    q_id = params[:q_id].to_i
    Tag.where(name: new_tag).first_or_create!
    new_tag_id = Tag.where(name: new_tag).pluck(:id)[0]
    tagging = Tagging.new(question_id: q_id, tag_id: new_tag_id)
    tagging.save!

  end

  def add_comment

    comment = Comment.new(body: params[:body])
    comment.user_id = current_user.id
    comment.question_id = params[:id]
    comment.save!

  end

  def upvote
    answer = Answer.find(params[:id])
    if current_user.already_upvoted(answer)
      answer.upvotes.where(user_id: current_user.id).destroy_all
    else
      answer.upvotes.where(user_id: current_user.id).first_or_create
    end
  end

  def follow
    question = Question.find(params[:id])
    if current_user.already_followed(question)
      question.follows.where(user_id: current_user.id).destroy_all
    else
      question.follows.where(user_id: current_user.id).first_or_create
    end
  end

  def search
    keyword = params[:keyword]
    tags = Tag.starts_with(keyword).sort_by(&:question_count).reverse
    data = {}
    data[:tags] = []
    tags.each do |tag|
      data[:tags].push([tag.name, tag.questions.count])
    end
    respond_to do |format|
      format.json { render json: data }
    end
  end

  private

  def question_params
    params.require(:question).permit(:description, :title, :all_tags)
  end

  def answer_params
    params.require(:answer).permit(:description)
  end

  def sort_column
    params[:sort] || 'follows'
  end

  def sort_direction
    params[:direction] || 'desc'
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
