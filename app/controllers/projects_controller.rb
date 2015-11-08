class ProjectsController < ApplicationController

  def create
    @project = Project.new(params_list)
    @project.company_id = current_user.company_id
    @project.parent_id = -1
    
    respond_to do |format|
      if @project.save && params[:user_id] == current_user.id
        format.json {render json: @project}
      else
        format.json {render status: :unprocessable_entity}
      end
    end
  end

	def show
		project = Project.find(params[:id])
    snippets = project.snippets
		members = project.users
		subscribers = project.subscriptions.pluck(:user_id)

		# Add some stats to project regarding current user
		project_full = []
		
		# Get the user's role for this project
		if ProjectsUser.where(:user_id => current_user.id).where(:project_id => project.id).last
			project_role = ProjectsUser.where(:user_id => current_user.id).where(:project_id => project.id).last.role
		else
			project_role = "No Role"
		end

		project_full.push({ project: project, subscribed: current_user.subscribed_project(project.id), role: project_role })

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

		# Add full snippet info
		snippets_full = []
		snippets.each do |snippet|
			snippets_full.push({ snippet: snippet, author_name: snippet.user.name })
		end

		respond_to do |format|
			format.json { render json: { project: project_full, members: members_full, subscribers: subscribers_full, snippets: snippets_full } }
		end
	end

	 private

  def params_list
    params.require(:project).permit(:parent_id, :company_id, :id, :name, :description)
  end
end
