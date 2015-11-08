class UserMailer < ApplicationMailer
	default from: 'digest@gosnipit.com'
 
  def digest_email(project)
    @project = project
    @subscribers = User.where(:id => @project.subscriptions.pluck(:user_id))
    @snippets = @project.snippets.where('created_at >= ?', 1.week.ago)

    # Using a Proc to send to ALL subscribers for that particular project
    mail(	to: Proc.new { @subscribers.pluck(:email) }, 
    			subject: "Weekly Snippet Digest Email | #{@project.name.titleize}")

  end
end