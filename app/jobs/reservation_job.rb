class ReservationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

	# Tell the ReservationMailer to send a booking email after save
		# deliver_later means if mailing server is down, any command below this will still proceed, but not deliver_now
	ReservationMailer.booking_email(args[0], args[1], args[2]).deliver_later
	# from reservations_controller, args[0] is @reservation.user, args[1] is @listing, args[2] is @reservation.id

  end
end
