class DashboardController < ApplicationController

	def dashboard_page
		user = User.find(params[:id])
		projects = user.projects
		subscriptions = user.subscriptions
		snippets = user.snippets 

		respond_to do |format|
			format.json { render json: { user: user, projects: projects, subscriptions: subscriptions, snippets: snippets } }
		end	
	end

end
