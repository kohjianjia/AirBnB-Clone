class UsersController < Clearance::UsersController

	# acquire from users => new.html.erb
	def new
		@user = User.new
	end

	def create
		user = User.new(user_params)
		user.save
		redirect_to sign_in_path
	end

	private
	# overriding a certain part of the users controller

# 	def user_from_params
# 	    email = user_params.delete(:email)
# 	    password = user_params.delete(:password)

# 	    Clearance.configuration.user_model.new(user_params).tap do |user|
# 	      user.email = email
# 	      user.password = password
# 	    end
# 	  end

# 	  def user_params
# 	    params[Clearance.configuration.user_parameter] || Hash.new
# 	  end
# 	end

	def user_params
  	  # params will require a user key, and user key will require the 5 keys
      params.require(:user).permit(:email, :password, :name, :gender, :age)
    end

end