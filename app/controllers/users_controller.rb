class UsersController < ApplicationController

	def create
		@user = User.create(user_params)
		redirect_to '/'
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :contact_number, :date_of_birth, :email, :password)
	end

end