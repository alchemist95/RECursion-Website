class HomeController < ApplicationController

	def index
		@home_page = true
		@future_events = Event.where('start_time > ?', DateTime.now).limit(3)
		@past_events = Event.order(:start_time).where('start_time < ?', DateTime.now).limit(3)		
	end

	def forum
		@forum_page = true
		@questions = Question.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
		@followed_questions = Question.all.sort_by(&:follow_count).reverse[0,5]
		@upvoted_questions = Question.all.sort_by(&:upvote_count).reverse[0,5]
	end

	def blog
		@blog_page = true
		@posts = Post.all.paginate(page: params[:page], per_page: 15)
		@liked_posts = Post.all.sort_by(&:like_count).reverse[0,5]
	end

	def getstarted		
	end

	def events

	end

	def team

	end

end
