class ListingsController < ApplicationController
	def index
		render template: 'listings/index'
	end

	def new

		@listing = Listing.new
		

	end

	def create

		@listing = Listing.new(listing_params)
	end

	private

	def listing_params

		params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id)

	end
end