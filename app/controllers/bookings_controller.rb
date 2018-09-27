class BookingsController < ApplicationController

  
	def new

		@booking = Booking.new

	end

	def show

		@booking = Booking.find(params[:id])
		@client_token = Braintree::ClientToken.generate

	end

	def create
		@booking = Booking.new(booking_params)
		@listing = Listing.find(booking_params[:listing_id])

		@booking.total_cost = ((booking_params[:check_in]...booking_params[:check_out]).count * @listing.price)


		if @booking.save

			SendEmailJob.perform_later(@booking.id, current_user.id)
			flash[:notice] = "Booking Successfully Made! Please make immediate payment to secure booking!"
			redirect_to "/bookings/#{@booking.id}"

		else

			flash[:notice] = "Unable to make booking, dates already taken!"
			redirect_to "/listings/#{params[:listing_id]}"

		end
	end

	def view_all

		@booking = Booking.where(user_id: current_user.id) 

	end

	def cancel

		booking = Booking.find(params[:id])

		if booking.destroy

			flash[:notice] = "Booking cancelled! You will receive an email once the refund is complete!"
			redirect_to '/bookings/view_all'

		else

			flash[:notice] = "Unable to cancel booking! Please contact Admin if problems persist!"
			redirect_to "/bookings/#{params[:id]}"
		end

	end

	def return_dates


		@listing = Listing.find(params[:listing_id])

		check_in = @listing.bookings.each_with_object([]) do |booking, array|

			array << booking.check_in

		end

		check_out = @listing.bookings.each_with_object([]) do |booking, array|

			array << booking.check_out

		end

		render :json => {check_in: check_in, check_out: check_out}

	end

	private

	def booking_params

		params.permit(:check_in, :check_out, :listing_id, :user_id, :payment_status)
		

	end
end

