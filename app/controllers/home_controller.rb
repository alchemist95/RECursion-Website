class HomeController < ApplicationController
	helper_method :sort_column, :sort_direction

	def index
		@home_page = true
		@future_events = Event.where('start_time > ?', DateTime.now).limit(3)
		@past_events = Event.order(:start_time).where('start_time < ?', DateTime.now).limit(3)		
	end

	def forum
		
		@forum_page = true
		if sort_column == 'Answers'
			@questions = Question.all.sort_by(&:answer_count)
		elsif sort_column == 'Date'
			@questions = Question.order('created_at')			
		else
			@questions = Question.all.sort_by(&:follow_count)
		end	

		if sort_direction == 'desc'
			@questions = @questions.reverse
		end

		@questions = @questions.paginate(page: params[:page], per_page: 15)

		@tags = Tag.all.sort_by(&:question_count).reverse[0,10]

	end

	
	def getstarted	
		@get_started_page = true	
	end

	def team
	end

	private

	def sort_column
		params[:sort] || 'follows'
	end

	def sort_direction
		params[:direction] || 'desc'
	end

end
