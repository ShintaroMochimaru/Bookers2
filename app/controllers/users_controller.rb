class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :check, only: [:update, :edit]
	def index
		@users = User.all
		@book = Book.new
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		user = User.find(current_user.id)
		if user.update(user_params)
			flash[:notice] = "successfully"
			redirect_to user_path(current_user.id)
		else
			 	flash[:alart] = "error"
			 	@user = User.find(params[:id])
			 	render :edit
		
		end
	end
		private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
	def check
		user = User.find(params[:id])
		if current_user.id != user.id
			redirect_to user_path(current_user)
		end
	end
end