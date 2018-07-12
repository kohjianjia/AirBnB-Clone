# mailer controller
class ReservationMailer < ApplicationMailer

	default from: 'jjkohtest@gmail.com'

	# booking_email method is being called in reservations_controller.rb
	def booking_email(customer, host, reservation_id)
		@customer = customer
		@host = host
		@reservation_id = reservation_id
		@url  = "http://localhost:3000/listings/#{@host.id}/reservations/#{@reservation_id}"
		email_with_name = %("#{@host.user.name}" <#{@host.user.email}>)
		mail(to: 'jjkohtest@gmail.com', subject: 'Yay! You\'ve got a booking.')
	end

end



