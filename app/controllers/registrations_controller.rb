class RegistrationsController < Devise::RegistrationsController

	def create
		company = Company.find_or_create_by(name: params[:user][:company])
		user = User.new(:email => params[:user][:email], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation], :first_name => params[:user][:first_name], :last_name => params[:user][:last_name], :company_id => company.id)

		#If a new company, need to add admin_id of current user
		unless company.admin_id
			company.admin_id = user.id
		end

		respond_to do |format|
			if user.save
			 format.json { render json: user }
			else
		 	 format.json { render json: "false"}
		 	end
		end
	end


private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone, :location, :user_id, :password, :password_confirmation, :company)
  end

end 