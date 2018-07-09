class ListingsController < ApplicationController
  #             clearance method
  before_action :require_login, only: [:index, :new, :create]
  before_action :check_update_rights, only: [:update, :edit]
  before_action :check_verification_rights, only: [:verify]

  before_action :find_listing, only: [:show, :edit, :verify]

  def index
  end

  def new
    @listing = Listing.new
  end

  def show
    @user = User.find(1)
  end

  def create
  	listing = Listing.new(listing_params)
    # specify the owner of the listing
  	listing.user_id = current_user.id
    # byebug
  	if listing.save
      flash[:listing_saved] = "Successfully created listing."
  	  redirect_to homepage_index_path
    else
      redirect_back
    end
  end

  def edit
    # only user || admin can edit & update
  end

  def verify
    if @listing.verification? == true
      @listing.update(verification:false)
    else
      @listing.update(verification:true)
    end

    if @listing.save
      redirect_to listing_path(@listing)
    end
  end

  private
  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    # strong params
  	params.require(:listing).permit(:title, :city, :address, :summary, :description, :home_type, :room_type, :guest_number, :pricing, :user_id, :amenity => [])
  end

  def check_update_rights
    @listing = Listing.find(params[:id])
    if current_user.role != @listing.user_id && !current_user.superadmin?
      redirect_to homepage_index_path
    end
  end

  def check_verification_rights
    if !current_user.superadmin? || !current_user.moderator?
      flash[:error] = "Access denied"
    end
  end
  

end
