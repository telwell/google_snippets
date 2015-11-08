class UsersController < ApplicationController

	def index
		
	end

	def new
		@user = User.new
	end

	def show
		# TODO: Add project name to snippets

		user = User.find(params[:id])
		projects = user.projects
		
		snippets = user.snippets
		snippets_full = []

		snippets.each do |snippet|
			snippets_full.push({ snippet: snippet, project: snippet.project })
		end

		respond_to do |format|
			format.json { render json: { user: user, projects: projects, snippets: snippets_full } }
		end
	end

	def create
		company = Company.find_or_create_by(name: params[:company_name])
		user = User.new(params[:user])
		user.company_id = company.id
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
  def params_list
    params.require(:user).permit(:email, :first_name, :last_name, :phone, :location, :user_id, :user, :registration)
  end

  

end
