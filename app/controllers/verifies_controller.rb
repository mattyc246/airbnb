class VerifiesController < ApplicationController

	def create
		listing = Listing.find(params[:listing_id])
		

		# Listing.update(verify_params)
		listing.verified = true
		listing.save

		# content_type :json
		# 	{verify: listing.verified}.to_json		
		respond_to do |format|
			format.js { render :json => listing.verified }
			
		end

	end

	private

	def verify_params

		params.require(:verify).permit(:verified)

	end

end