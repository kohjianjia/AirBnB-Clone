class UsersController < Clearance::UsersController

	def index
		@users = User.all
	end

	# acquire from users => new.html.erb
	def new
		@user = User.new
	end

	def create
		user = User.new(user_params)
		user.save
		redirect_to sign_in_path
	end

	def show
    	@user = User.find(params[:id])
    	# @reservation = Reservation.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])

	end

	def update
		@user = User.find(params[:id])
		@user.update(name: params[:user][:name], gender: params[:user][:gender], image: params[:user][:image])
		flash[:update] = "Profile updated!"
		redirect_to user_path(@user)
	end

	private
	# overriding a certain part of the users controller

# 	def user_from_params
# 	    email = user_params.delete(:email)
# 	    password = user_params.delete(:password)
# 	    name = user_params.delete(:name)
# 	    gender = user_params.delete(:gender)
# 	    age = user_params.delete(:age)

# 	    Clearance.configuration.user_model.new(user_params).tap do |user|
# 	      user.email = email
# 	      user.password = password
# 	      user.name = name
# 	      user.gender = gender
# 	      user.age = age
# 	    end
# 	  end

# 	  def user_params
# 	    params[Clearance.configuration.user_parameter] || Hash.new
# 	  end
# 	end

	def user_params
  	  # params will require a user key, and user key will require the 5 keys
      params.require(:user).permit(:email, :password, :name)
    end


end