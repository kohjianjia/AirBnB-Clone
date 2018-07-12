class ReservationsController < ApplicationController

	def create
		# byebug
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new(reservation_params)
		@reservation.listing_id = @listing.id
		@reservation.user_id = current_user.id
		# byebug
		# respond_to do |format|
			if @reservation.save
		        # Tell the UserMailer to send a welcome email after save
		        	# deliver_later means if mailing server is down, any command below this will still proceed, but not deliver_now
		        ReservationMailer.booking_email(@reservation.user, @listing, @reservation.id).deliver_later

		        # format.html { redirect_to(@reservation.user_id, notice: 'Reservation was successfully booked.') }
		        # format.json { render json: @reservation.user_id, status: :created, location: @reservation.user_id }

			    flash[:reserved] = "Successfully reserved property!"
			  	redirect_to listing_reservation_path(@listing, @reservation)
		    else
		    	# format.html { render action: 'new' }
        		# format.json { render json: @reservation.user_id.errors, status: :unprocessable_entity }

			    flash[:unavailable] = "#{@reservation.errors.full_messages}"
			    redirect_back(fallback_location: homepage_path)
		    end
		# end
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	private
	def reservation_params
    	# strong params
  		params.require(:reservation).permit(:start_date, :end_date, :special_request, :total_price, :user_id, :listing_id)
	end

end

