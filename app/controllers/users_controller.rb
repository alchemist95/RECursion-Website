class UsersController  < ApplicationController

	def update_profile
		if current_user
			if current_user.nickname.blank? || current_user.college.blank? || current_user.name.blank?
				@user = []
		        @user << { name: current_user.name, nickname: current_user.nickname, college: current_user.college }
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
		@user = User.where(nickname: params[:nickname]).first
	end


end
