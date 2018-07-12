class ApplicationMailer < ActionMailer::Base

	# email that will be visible when receiptient receives the email
  	default from: 'notification@airbnbclone.com'
  	layout 'mailer'

end
