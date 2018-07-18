class ListingsController < ApplicationController
  #             clearance method
  before_action :require_login, only: [:new, :create, :edit, :update, :verify, :destroy]
  before_action :find_listing, only: [:show, :edit, :verify, :update, :destroy]
  before_action :check_update_rights, only: [:update, :edit]
  before_action :check_verification_rights, only: [:verify]
  before_action :ajax_search, only: [:match, :search]

  def index
  end

  def new
    @listing = Listing.new
  end

  def show
    # @reservation = Reservation.new
  end

  def create
  	listing = Listing.new(listing_params)
    # specify the owner of the listing
  	listing.user_id = current_user.id
  	if listing.save
      flash[:listing_saved] = "Successfully created listing."
  	  redirect_to homepage_path
    else
      flash[:blank] = "#{listing.errors.full_messages}"
      redirect_back(fallback_location: homepage_path)
      # redirect_to :back 
    end
  end

  def edit
    # only user || admin can edit & update
  end

  def update
    @listing.update(edit_listing_params)
    flash[:updated_listing] = "Listing updated!"
    redirect_to listing_path(@listing)
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

  def match
    respond_to do |format|
      format.json { render json: @listings }
      format.html
    end
  end

  def search
    if params[:city_search].blank? && params[:title_search].blank?
      flash[:no_match] = "Sorry! No match found."
      redirect_back(fallback_location: homepage_path)
    elsif !@listings.empty?
      render :index #=> listings/index.erb
    else 
      flash[:no_match] = "Sorry! No match found."
      redirect_back(fallback_location: homepage_path)
    end
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    # strong params
  	params.require(:listing).permit(:title, :city, :address, :summary, :description, :home_type, :room_type, :guest_number, :pricing, :user_id, {images: []}, :amenity => [])
  end

  def edit_listing_params
    params.require(:listing).permit(:title, :summary, :description, :home_type, :room_type, :guest_number, :pricing, {images: []}, :amenity => [])
  end

  def check_update_rights
    @listing = Listing.find(params[:id])
    if current_user.role != @listing.user_id && current_user.moderator? 
      redirect_to homepage_path
    end
  end

  def check_verification_rights
    if !current_user.superadmin? || !current_user.moderator?
      # flash[:error] = "Access denied"
      flash[:changed] = "verification edited"
    end
  end

  def ajax_search
    @listings = Listing.all
    #                                        search is from the form at applicaition.html.erb where name="search"
    @listings = @listings.search_city(params[:city_search]) if params[:city_search].present? #=> [].city listing_obj.city
    @listings = @listings.search_title(params[:title_search]) if params[:title_search].present?
  end

end


