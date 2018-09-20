class UsersController < ApplicationController

	def index

		@user = User.all.page params[:page]

	end

	def create
		@user = User.create(user_params)
		redirect_to '/'
	end

	def show
		@user = User.find(params[:id])
	end

	def update

		user = User.find(params[:id])

		if user.update(user_params)

			flash[:notice] = "Successfully Updated #{user.first_name}!"
			redirect_to action: "show", id: params[:id]

		else

			flash[:notice] = 'Unsuccessful! Invalid Change!'
			redirect_to action: "show", id: params[:id]

		end
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :contact_number, :date_of_birth, :email, :password, :auth_level)
	end

end