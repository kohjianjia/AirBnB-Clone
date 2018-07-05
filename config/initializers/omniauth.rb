Rails.application.config.middleware.use OmniAuth::Builder do
	#                        ENV connects to application.yml
	provider :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET'],

	{
		# requesting only basic info from google
      	scope: 'email, profile',

      	# select_account allows user to choose from his existing list of google account
      	prompt: 'select_account',

      	# profile photo size
      	image_aspect_ratio: 'square',
      	image_size: 50
    }

	# other providers, if any

end