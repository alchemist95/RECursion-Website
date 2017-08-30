class HomeController < ApplicationController

	def index
		@home_page = true
		# @events = Event.all
		# @last_week_update = WeeklyUpdates.last
	end

	def forum
		@forum_page = true
		@questions = Question.all.paginate(page: params[:page], per_page: 5)
	end

	def blog
		@blog_page = true
		@posts = Post.all.paginate(page: params[:page], per_page: 5)
	end

	def getstarted
		@getstarted_page = true
		
	end

	def events

	end

	def team

	end

end
