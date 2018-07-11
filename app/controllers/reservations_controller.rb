class ReservationsController < ApplicationController

	def create
		# byebug
		listing = Listing.find(params[:listing_id])
		reservation = Reservation.new(reservation_params)
		reservation.listing_id = listing.id
		reservation.user_id = current_user.id
		# byebug
		if reservation.save
	      flash[:reserved] = "Successfully reserved property!"
	  	  redirect_to listing_reservation_path(listing, reservation)
	    else
	      flash[:unavailable] = "#{reservation.errors.full_messages}"
	      redirect_back(fallback_location: homepage_path)
	    end
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	private
	def reservation_params
    # strong params
  	params.require(:reservation).permit(:start_date, :end_date, :special_request, :user_id, :listing_id)
	end

end


