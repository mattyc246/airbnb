class HomeController < ApplicationController

  def index

  	@listing = Listing.find(rand(1..Listing.count))


  end
  
end
