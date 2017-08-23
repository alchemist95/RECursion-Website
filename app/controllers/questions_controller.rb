class QuestionsController < ApplicationController

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
    @answers = @question.answers
    @answer = Answer.new
  end

  def submit_answer
    
    answer = Answer.new(answer_params)
    answer.user_id = current_user.id
    answer.question_id = params[:id]
    answer.save!
    redirect_to question_path

  end
 
  private

  def question_params
  	params.require(:question).permit(:description, :title)
  end

  def answer_params
    params.require(:answer).permit(:description)
  end

end
