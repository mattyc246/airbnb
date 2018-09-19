class ListingsController < ApplicationController
	def index

		@listing = Listing.all
			
	end

	def new

		@listing = Listing.new
		

	end

	def show
		@listing = Listing.all
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

	end

	private

	def listing_params

		params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id)

	end
end