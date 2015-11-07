class ProjectsController < ApplicationController
	def project_page
		project = Project.find(params[:id])
		members = project.users
		subscribers = project.subscriptions

		respond_to do |format|
			format.json { render json: { project: project, members: members, subscriptions: subscriptions } }
		end
	end
end
