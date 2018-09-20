class ListingsController < ApplicationController
	def index

		@listing = Listing.all
			
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

		if @listing.save
		

			redirect_to '/'

		else

		end

	end

	def update

		listing = Listing.find(params[:id])

	

		

		if listing.update(listing_params)

			flash[:notice] = 'Successful!'
			redirect_to action: "show", id: params[:id]


		else

			flash[:notice] = 'Unsuccessful!'
			redirect_to action: "show", id: params[:id]


		end

	end

	private

	def listing_params

		params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, :listing)

	end
end