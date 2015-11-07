class ProjectsController < ApplicationController
	def project_page
		project = Project.find(params[:id])
		members = project.users
		respond_to do |format|
			format.json { render json: {project: project, members: members} }
		end
	end
end
