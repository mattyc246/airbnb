class BookingsController < ActionController::Base
  
	def new

		@booking = Booking.new

	end

	def create

		byebug

	end

	private

	def booking_params

		params.permit(:check_in, :check_out, :listing_id)
		

	end
end

