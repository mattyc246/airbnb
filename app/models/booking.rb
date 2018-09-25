class Booking < ApplicationRecord

	belongs_to :user
	belongs_to :listing
	validate :check_dates

	def check_dates

		current_bookings = Booking.where(listing_id: self.listing.id)



		self.check_in

	end

end
