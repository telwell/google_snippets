class DashboardController < ApplicationController

	def show
		user = User.find(params[:id])

		projects = Company.find(user.company_id).projects
    
		subscriptions = user.subscriptions

    
		snippets = Snippet.where(:user_id => user.id).where(:project_id => user.subscriptions.pluck(:project_id))

		respond_to do |format|
			format.json { render json: { user: user, projects: projects, subscriptions: subscriptions, snippets: snippets } }
		end	
	end

end
