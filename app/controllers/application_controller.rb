class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
	skip_before_filter  :verify_authenticity_token

  	helper_method :current_user
  	helper_method :authenticate
  
	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
	def authenticate
 		if !current_user
			flash[:error] = "Please Sign In"
			redirect_to root_path
		end
	end


end
