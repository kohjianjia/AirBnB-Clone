class HomepageController < ApplicationController

  def index
  	@listings = Listing.order("created_at DESC").page(params[:page]).per(9) 
  end

end
