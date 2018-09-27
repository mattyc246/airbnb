class ListingsController < ApplicationController
	def index

		@listing = Listing.order(:created_at).page params[:page]
			
	end

	def new


		@listing = Listing.new
		

	end

	def show
		
		@listing = Listing.find(params[:id])
		
	end

	def create

		@listing = Listing.new(listing_params)

		@listing.user_id = current_user.id

		if current_user.auth_level == "host" || current_user.auth_level == "superadmin"

			if @listing.save
			
				flash[:notice] = "Successfully Hosted Listing!"
				redirect_to '/listings/#{@listing.id}'

			else

				flash[:notice] = "Unsuccessful, if problems persist, please report!"
				redirect_to '/listings/new'

			end

		else

			flash[:notice] = "Please request for host status to create listing!"
			redirect_to(fallback_location: root_path)

		end

	end

	def update

		listing = Listing.find(params[:id])

	
		if current_user.id == listing.user.id || current_user.auth_level == "superadmin"
		

			if listing.update(listing_params)

				flash[:notice] = 'Successful!'
				redirect_to action: "show", id: params[:id]


			else

				flash[:notice] = 'Unsuccessful!'
				redirect_to action: "show", id: params[:id]


			end

		else

			flash[:notice] = 'Please contact administrator to change this listing!'
			redirect_to(fallback_location: root_path)

		end

	end

	def destroy

		listing = Listing.find(params[:id])

		if current_user.id == listing.user.id || current_user.auth_level == "superadmin"

			if listing.destroy

				flash[:notice] = 'Listing removed succesfully!'
				redirect_to action: "index"	

			else

				flash[:notice] = 'Unable to delete listing!'
				redirect_to action: "index"

			end

		else

			flash[:notice] = "You are not authorized to remove this listing!"
			redirect_to(fallback_location: root_path)

		end

	end

	def remove_image

		@listing = Listing.find(params[:id])

		if current_user.id == listing.user.id || current_user.auth_level == "superadmin"

			remain_images = @listing.avatars
			deleted_image = remain_images.delete_at(params[:i_id].to_i)
			deleted_image.try(:remove!)
			@listing.avatars = remain_images

			if @listing.save

				flash[:notice] = 'Photo Deleted!'
				redirect_to listing_path(@listing)

			else

				flash[:notice] = 'Unable to delete photo! Please try again!'
				redirect_to listing_path(@listing)

			end

		else

			flash[:notice] = "You do not have the authority to peform this action!"
			redirect_to listing_path(@listing)

		end
	end

	def filter

		if search_params.include?("guest_number") || search_params.include?("room_number")

			value = search_params.values[0].split('..').map{|d| Integer(d)}

			new_hash = {search_params.keys[0] => value[0]..value[1]}

			@listing = Listing.where(new_hash).page params[:page]

		else

			@listing = Listing.where(search_params).page params[:page]

		end


			respond_to do |format|
		  		format.js {@listing}
		  		format.html { render 'listings/index' }
			end
	end

	def search

		@autofill = []

		search_return = Listing.search_by_city(params[:search])

		search_return.each do |listing|

			if !@autofill.include?(listing.city)

				@autofill << listing.city

			end

		end

		respond_to do |format|

			format.js {@autofill}

		end	
	end
	
	private

	def search_params

		params.permit(:verified ,:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, :listing, :search)

	end

	def listing_params

		params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, :listing, {avatars: []})

	end
end