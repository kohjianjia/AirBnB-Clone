class HomepageController < ApplicationController

  def index
  	@listings = Listing.order("created_at DESC").page(params[:page]).per(5) 
  end

end
