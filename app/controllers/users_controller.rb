class UsersController < ApplicationController

	# /user/new and the default view is loaded; which contains a Registration form 
	def new
	end

	# create is called when the Registration form is submitted.  We must create the new user from the data supplied in the form
	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Your registration was successful!"
			redirect_to '/'
		else
			flash[:alert] = "There was a problem creating your account.  Please try again."
			redirect_to :back
		end
	end

private
	# mass-assignment protection
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end
