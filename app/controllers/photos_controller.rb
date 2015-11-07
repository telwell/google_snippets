class PhotosController < ApplicationController

	def new
		@user = User.find(params[:user_id])
		@photo = Photo.new
	end

	def create
		@user = User.find(params[:user_id])
		@photo = Photo.new( photo_params )

		if @photo.save
			@user.update(:avatar_id => @photo.id)
			flash['success'] = "Avatar added successfully!"
			redirect_to root_path
		else
			render :new
			flash['error'].now = "Avatar not added"
		end
	end

private

	def photo_params
		params.require(:photo).permit(:photo)
	end

end
