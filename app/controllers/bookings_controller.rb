class BookingsController < ActionController::Base
  
	def new

		@booking = Booking.new

	end

	def create

		@booking = Booking.new(booking_params)

		if @booking.save

			flash[:notice] = "Booking Successfully Made! Please make immediate payment to secure booking!"
			redirect_to "/listings/#{params[:listing_id]}"

		else

			flash[:notice] = "Unable to make booking, dates already taken!"
			redirect_to "/listings/#{params[:listing_id]}"

		end
	end

	private

	def booking_params

		params.permit(:check_in, :check_out, :listing_id, :user_id)
		

	end
end

