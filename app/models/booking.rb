class Booking < ApplicationRecord

	belongs_to :user
	belongs_to :listing
	validate :check_overlap

	def check_overlap
		listing = self.listing
		bookings = self.listing.bookings

		bookings.each do |x|

			dates_taken = 

		end
	end



end
