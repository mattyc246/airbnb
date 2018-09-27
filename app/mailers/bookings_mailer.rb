class BookingsMailer < ApplicationMailer
	default from: 'bookings@example.com'


	def booking_email(booking_id, check_in, check_out, total_cost)

		@user = current_user

		@booking = Booking.find(booking_id)

		@listing = @booking.listing

		@days = (@booking[:check_in]...@booking[:check_out]).count

		@host = @listing.user

		mail(to: @user.email, subject: "Booking confirmation for Booking ##{@booking.id}")

	end
end
