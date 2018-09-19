class HomeController < ApplicationController
  def index

  	@listing = Listing.all.order(created_at: :desc).limit(3)


  end
end
