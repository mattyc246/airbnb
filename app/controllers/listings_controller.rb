class ListingsController < ApplicationController
	def index

		@listing = Listing.order(:created_at).page params[:page]
			
	end

	def new


		@listing = Listing.new
		

	end

	def show
		
		@listing = Listing.find(params[:id])
		
	end

	def create

		@listing = Listing.new(listing_params)

		@listing.user_id = current_user.id

		if current_user.auth_level == "host" || current_user.auth_level == "superadmin"

			if @listing.save
			
				flash[:notice] = "Successfully Hosted Listing!"
				redirect_to '/listings/#{@listing.id}'

			else

				flash[:notice] = "Unsuccessful, if problems persist, please report!"
				redirect_to '/listings/new'

			end

		else

			flash[:notice] = "Please request for host status to create listing!"
			redirect_to(fallback_location: root_path)

		end

	end

	def update

		listing = Listing.find(params[:id])

	
		if current_user.id == listing.user.id || current_user.auth_level == "superadmin"
		

			if listing.update(listing_params)

				flash[:notice] = 'Successful!'
				redirect_to action: "show", id: params[:id]


			else

				flash[:notice] = 'Unsuccessful!'
				redirect_to action: "show", id: params[:id]


			end

		else

			flash[:notice] = 'Please contact administrator to change this listing!'
			redirect_to(fallback_location: root_path)

		end

	end

	def destroy

		listing = Listing.find(params[:id])

		if current_user.id == listing.user.id || current_user.auth_level == "superadmin"

			if listing.destroy

				flash[:notice] = 'Listing removed succesfully!'
				redirect_to action: "index"	

			else

				flash[:notice] = 'Unable to delete listing!'
				redirect_to action: "index"

			end

		else

			flash[:notice] = "You are not authorized to remove this listing!"
			redirect_to(fallback_location: root_path)

		end

	end
	
	private

	def listing_params

		params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, :listing, {avatars: []})

	end
end