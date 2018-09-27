class HomeController < ApplicationController

  def index

  	@listing = Listing.all


  end
  
end
