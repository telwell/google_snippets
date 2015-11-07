class UsersController < ApplicationController

	def index
		
	end

	def new
		@user = User.new
	end


private
	def user_params
		#Strong params for user	
	end

end
