class User < ActiveRecord::Base
	has_many :projects_users
	has_many :projects, through: :projects_users
	has_many :snippets
	belongs_to :company
end