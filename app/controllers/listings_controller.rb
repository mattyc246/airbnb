class ListingsController < ApplicationController
	def index
	end

	def new

		@listing = Listing.new
		

	end


	def create

		@listing = Listing.new(listing_params)

		@listing.user_id = current_user.id

		p @listing

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