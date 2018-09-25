class Booking < ApplicationRecord

	belongs_to :user
	belongs_to :listing
	validate :check_dates

	def check_dates

		current_bookings = Booking.where(listing_id: self.listing.id)

		current_bookings.each do |booking|

			if (self.check_in..self.check_out).overlaps?(booking.check_in..booking.check_out)
				errors.add(:check_in, "There is an overlap with the dates.")
			end

		end

	end

end
