class BookingsMailer < ApplicationMailer
	default from: 'bookings@example.com'


	def booking_email(booking_id, user_id)

		@user = User.find(user_id)

		@booking = Booking.find(booking_id)

		@listing = @booking.listing

		@days = (@booking[:check_in]...@booking[:check_out]).count

		@host = @listing.user

		mail(to: @user.email, subject: "Booking confirmation for Booking ##{@booking.id}")

	end
end
