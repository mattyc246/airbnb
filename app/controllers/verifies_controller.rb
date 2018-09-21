class VerifiesController < ApplicationController

	def create

		if current_user.auth_level == "moderator"

			listing = Listing.find(params[:listing_id])
			

			# Listing.update(verify_params)
			listing.verified = true
			listing.save

			# content_type :json
			# 	{verify: listing.verified}.to_json		
			respond_to do |format|
				format.js { render :json => listing.verified }
				
			end

		else

			flash[:notice] = "You are not Authorised to do this!"
			redirect_back(fallback_location: root_path)

		end

	end

	private

	def verify_params

		params.require(:verify).permit(:verified)

	end

end