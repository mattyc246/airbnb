class VerifyController < ApplicationController

	require 'json'

	def update

		listing = Listing.find(params[:id])

		Listing.update(verify_params)

		content_type :json
			{verify: listing.verified}.to_json		


	end

	private

	def verify_params

		params.require(:verify).permit(:verified)

	end

end