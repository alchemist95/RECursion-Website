class QuestionsController < ApplicationController
  before_action :authenticate, only: [:new]
  
  def new
  	@question = Question.new
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

  	@question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers
    @users = @answers.group(:user_id).pluck(:user_id)  
    @comments = @question.comments.order(created_at: :desc)

  end

  def submit_answer

    answer = Answer.new(answer_params)
    answer.user_id = current_user.id
    answer.question_id = params[:id]
    answer.save!
    redirect_to question_path

  end

  def add_comment

    comment = Comment.new(body: params[:body])
    comment.user_id = current_user.id
    comment.question_id = params[:id]
    comment.save!

  end


  def upvote
    question = Question.find(params[:id])
    if current_user.already_upvoted(question)
      question.upvotes.where(user_id: current_user.id).destroy_all 
    else
      question.upvotes.where(user_id: current_user.id).first_or_create
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

  private

  def question_params
  	params.require(:question).permit(:description, :title)
  end

  def answer_params
    params.require(:answer).permit(:description)
  end

end
