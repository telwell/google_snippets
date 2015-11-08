class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :projects_users
	has_many :projects, through: :projects_users
	has_many :snippets
	has_many :subscriptions
	belongs_to :company

	def name
		return "#{self.first_name} #{self.last_name}"
	end

	def subscribed_project(project_id)
		self.subscriptions.pluck(:project_id).include?(project_id) ? true : false
	end
end