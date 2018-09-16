class ListingsController < ApplicationController
	def index
		render template: 'listings/index'
	end

	def create
		# render template: 'listings/new'
	end
end