class UsersController < ApplicationController

	def index
		
	end

	def new
		@user = User.new
	end

	def show
		user = User.find(params[:id])
		projects = user.projects
		snippets = user.snippets

		respond_to do |format|
			format.json { render json: { user: user, projects: projects, snippets: snippets } }
		end
	end


private
	def user_params
		#Strong params for user	
	end

end
