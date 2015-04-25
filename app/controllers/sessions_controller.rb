class SessionsController < ApplicationController

	def new

	end

	def create
		#try authenticating the user; if successful an instance of the User model is returned
		@user = User.authenticate(params[:email], params[:password])
		#if an instance is returned and @user is not nil...
		if @user
			#notify the user they have been logged in using the Rails flash
			flash[:notice] = "You are now logged in"
			#Actually log in the user by storing the userID in the session 
			session[:user_id] = @user.id
			#redirect to a landing page
			redirect_to '/'
		else
			#The database query was unsuccessful - perhaps the password is incorrect - so we must redirect
			flash[:alert] = "There was a problem with your log in attempt"
			redirect_to log_in_path
		end
	end


	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have successfully logged out"
		redirect_to '/'
	end
end

