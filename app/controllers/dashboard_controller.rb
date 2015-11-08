class DashboardController < ApplicationController

	def show
		user = User.find(params[:id])

		projects = Company.find(user.company_id).projects
		
		# Add some more information to the projects
		projects_subs = []

		projects.each do |project|
			projects_subs.push({ project: project, subscribed: user.subscribed_project(project.id) })
		end

		snippets = Snippet.where(:project_id => user.subscriptions.pluck(:project_id))
		snippets_full = []

		# Add some more information to the snippets
		snippets.each do |snippet|
			if ProjectsUser.where(:user_id => snippet.user.id).where(:project_id => snippet.project.id).last
				user_role = ProjectsUser.where(:user_id => snippet.user.id).where(:project_id => snippet.project.id).last.role
			else
				user_role = "no role"
			end

			snippets_full.push({ snippet: snippet, user_name: snippet.user.name, project: snippet.project, role: user_role })
		end


		respond_to do |format|
			format.json { render json: { user: user, projects: projects_subs, snippets: snippets_full } }
		end	
	end

end
