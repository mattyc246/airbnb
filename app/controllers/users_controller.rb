class UserController < ApplicationController

	def create
		@user = User.create(
			params[:first_name],
			params[:last_name],
			params[:contact_number],
			params[:birthday],
			params[:email],
			params[:password]
			)
	end

end