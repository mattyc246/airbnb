class UsersController < ApplicationController

	def index

		if current_user.auth_level == "superadmin"

			@user = User.all.page params[:page]

		else

			flash[:notice] = "Unauthorised Access!"
			redirect_to '/'

		end

	end

	def create
		@user = User.create(user_params, auth_level: "basic")
		redirect_to '/'
	end

	def show
		@user = User.find(params[:id])
		@listing = @user.listings.all.page params[:page]
	end

	def update

		user = User.find(params[:id])

		if current_user.id == user.id || current_user.auth_level == "superadmin"

			if user.update(user_params)

				flash[:notice] = "Successfully Updated #{user.first_name}!"
				redirect_to action: "show", id: params[:id]

			else

				flash[:notice] = 'Unsuccessful! Invalid Change!'
				redirect_to action: "show", id: params[:id]

			end

		else

			flash[:notice] = "You are not Authorized to do this!"
			redirect_back(fallback_location: root_path)

		end

	end

	def destroy

		user = User.find(params[:id])

		if current_user.id == user.id || current_user.auth_level == "superadmin"

			if user.destroy

				flash[:notice] = "Thank you! We're sorry you had to go!"
				redirect_to '/'

			else

				flash[:notice] = "Error! Unable to delete account. Try again later."
				redirect_to action: "show", id: params[:id]

			end

		else

			flash[:notice] = "You are not Authorized to do this!"
			redirect_back(fallback_location: root_path)

		end

	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :contact_number, :date_of_birth, :email, :password, :auth_level)
	end

end