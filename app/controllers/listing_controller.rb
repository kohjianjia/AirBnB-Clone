class ListingController < ApplicationController

  def index
   end

  def new
  	@listing = Listing.new

  def create
  	listing = Listing.new(listing_params)
  	listing.user_id = current_user.id
    # byebug
  	if listing.save
      flash[:listing_saved] = "Successfully created listing."
  	  redirect_to homepage_index_path
    else
      redirect_back
    end
  end

  private
  def listing_params
    # strong params
  	params.require(:listing).permit(:title, :city, :address, :summary, :description, :home_type, :room_type, :guest_number, :pricing, :user_id, :amenity => [])
  end

end
