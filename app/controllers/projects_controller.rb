class ProjectsController < ApplicationController
	def show
		project = Project.find(params[:id])
		members = project.users
		subscribers = project.subscriptions

		respond_to do |format|
			format.json { render json: { project: project, members: members, subscribers: subscribers } }
		end
	end
end
