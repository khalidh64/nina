class RegistrationsController < Devise::RegistrationsController
	def create
		@user = User.new(signup_params)
		puts signup_params["secure_password"]
		if signup_params["secure_password"] == "A12345@m"
			if @user.valid?
				@user.add_role :admin
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
		params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation, :employee_code, :mobile, :secure_password)
	end

end