class DashboardController < ApplicationController

	def show
		user = User.find(params[:id])

		projects = Company.find(user.company_id).projects
		
		# Add some more information to the projects
		projects_subs = {}

		projects.each do |project|
			projects_subs[project.id] = { project: project, subscribed?: user.subscribed_project(project.id) }
		end
    
		subscriptions = user.subscriptions

		snippets = Snippet.where(:user_id => user.id).where(:project_id => user.subscriptions.pluck(:project_id))

		respond_to do |format|
			format.json { render json: { user: user, projects: projects_subs, subscriptions: subscriptions, snippets: snippets } }
		end	
	end

end
