class RegistrationsController < Devise::RegistrationsController
	def create
		@user = User.new(signup_params)
		puts signup_params["secure_password"]
		if signup_params["secure_password"] == "A12345@m"
			if @user.valid?
				if signup_params["role"] == "Admin"
					@user.add_role :admin
				elsif signup_params["role"] == "Partial Admin"
					@user.add_role :user
				else
					@user.add_role :normaluser
				end
	    		@user.save!
	      		flash[:notice] = "Success"
	      		redirect_to root_url, :notice => "Account created successfully."
		    else
		      flash[:notice] = "Somthing went wrong"
		      render :new
		    end
	  	else
	  		flash[:notice] = "You can't Sign up, Please contact your administrator"
	     	render :new
	  	end
	end

	private
	def signup_params
		params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation, :employee_code, :mobile, :secure_password, :role)
	end
end