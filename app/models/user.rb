class User < ApplicationRecord

	include Clearance::User
	#                          if user is deleted, everything related to the user will be deleted as well
	has_many :authentications, dependent: :destroy
	has_many :listings, dependent: :destroy
	has_many :reservations, dependent: :destroy

	#              0          1           2
	enum role: [:customer, :moderator, :superadmin]

	mount_uploader :image, ImageUploader

	# auth_hash returns requested info in a hash
	def self.create_with_auth_and_hash(authentication, auth_hash)
		# byebug
	   user = self.create!(
	   	# these info are required from a hash from google
	    name: auth_hash["info"]["name"],
	    email: auth_hash["info"]["email"],
	    # password cannot be nil (specified previously)
	    password: SecureRandom.hex(10),
	    gender: auth_hash["info"]["gender"]
	   )

	   # helper method that pushes am authentication object into an existing user
	   user.authentications << authentication
	   return user
	 end

	 # grab google to access google for user data
	 def google_token
	   x = self.authentications.find_by(provider: 'google_oauth2')
	   return x.token unless x.nil?
	 end
end
