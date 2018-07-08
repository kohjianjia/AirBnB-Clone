class SessionsController < Clearance::SessionsController
	
	def create
	    @user = authenticate(params)

	    sign_in(@user) do |status|
	      if status.success?
	        redirect_to homepage_index_path
	      else
	        flash.now.notice = status.failure_message
	        render template: "sessions/new", status: :unauthorized
	      end
	    end
	end

	def create_from_omniauth
	  auth_hash = request.env["omniauth.auth"]

	  #                signed in before user (same provider and uid), this is ran                       or if new user, then this is ran
	  authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
	  # byebug
	  # if: previously already logged in with OAuth
	  if authentication.user
	    user = authentication.user
	    # update the token when signed in user signs in again
	    authentication.update_token(auth_hash)
	    @next = "/homepage"
	    @notice = "Signed in!"

	  # else: user logs in with OAuth for the first time
	  else
	  	# no authentication, then create user
	  		# authentication object (line 5) and auth_hash is passed into this method
	    user = User.create_with_auth_and_hash(authentication, auth_hash)
	    # you are expected to have a path that leads to a page for editing user details
	    # # no edit user path exist
	    # @next = edit_user_path(user)
	    @next = "/homepage"
	    @notice = "User created. Please confirm or edit details"
	  end

	  sign_in(user)

	  # @next is specified at line 24
	  redirect_to @next, :notice => @notice
	end

end
