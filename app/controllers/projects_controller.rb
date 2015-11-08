class ProjectsController < ApplicationController
	def show
		project = Project.find(params[:id])
    snippets = project.snippets
		members = project.users
		subscribers = project.subscriptions

		respond_to do |format|
			format.json { render json: { project: project, members: members, subscribers: subscribers , snippets: snippets} }
		end
	end
end
