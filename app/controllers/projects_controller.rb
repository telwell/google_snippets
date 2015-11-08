class ProjectsController < ApplicationController
	def show
		project = Project.find(params[:id])
    snippets = project.snippets
		members = project.users
		subscribers = project.subscriptions

		# Add some stats to project regarding current user
		project_full = []
		
		# Get the user's role for this project
		if ProjectsUser.where(:user_id => current_user.id).where(:project_id => project.id).last
			project_role = ProjectsUser.where(:user_id => current_user.id).where(:project_id => project.id).last.role
		else
			project_role = "No Role"
		end

		project_full.push({ project: project, subscribed?: current_user.subscribed_project(project.id), role: project_role })

		# Add Full Names for all members
		members_full = []
		members.each do |member|
			members_full.push({ user_id: member, user_name: User.find(member).name })
		end

		# Add Full Names for all subscribers
		subscribers_full = []
		subscribers.each do |subscriber|
			subscribers_full.push({ user_id: subscriber, user_name: User.find(subscriber).name })
		end

		respond_to do |format|
			format.json { render json: { project: project_full, members: members_full, subscribers: subscribers_full, snippets: snippets} }
		end
	end
end
