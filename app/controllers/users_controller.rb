class UsersController  < ApplicationController

	def update_profile
		if current_user
			if current_user.nickname.blank? || current_user.college.blank? || current_user.name.blank?
				@user_page = true
				@user = []
		        @user << { name: current_user.name, nickname: current_user.nickname, college: current_user.college, dept: current_user.dept }
			else
				redirect_to root_url
			end
		else
			redirect_to root_url
		end
	end

	def save_update
		nickname = params[:nickname]
		user = User.where(nickname: nickname).first
		if user.nil? && !(nickname =~ /^[a-zA-Z0-9_]*$/).nil? && nickname.length > 1
			current_user.nickname = nickname
		end
		current_user.college = params[:college]
		current_user.name = params[:name]
		current_user.dept = params[:dept]
		current_user.save!
		flash[:notice] = "Welcome to Recursion"
		redirect_to root_url
	end

	def checknickname
		nickname = params[:nickname]
		user = User.where(nickname: nickname).first
		data = {}
	    data[:status] = if user.nil? && !(nickname =~ /^[a-zA-Z0-9_]*$/).nil?
	                      'GoodToGo'
	                    else
	                      'Nope'
	                    end
	    respond_to do |format|
	      format.json { render json: data }
	    end	
	end

	def profile
		@profile_page = true
		@user = User.where(nickname: params[:nickname]).first
		@followed_question_ids = @user.follows.pluck(:question_id)
		@answered_question_ids = @user.answers.pluck(:question_id, :id)
		total_follows = 0
		@user.questions.each do |question|
			total_follows += question.follows.count
		end 
		total_upvotes = 0
		@user.answers.each do |answer|
			total_upvotes += answer.upvotes.count
		end
		@rep = (total_follows+total_upvotes)*0.25
	end


end
