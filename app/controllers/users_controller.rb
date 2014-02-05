class UsersController < ApplicationController
	before_action :get_categories
	before_action :require_user, only:[:edit, :update]
	before_action :find_user, only:[:show, :edit, :update]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "注册成功."
			redirect_to root_path
		else
		  render 'new'
		end
	end

	def show
		@posts = @user.posts
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "更新成功."
			redirect_to @user
		else
			render 'edit'
		end
	end 


	private

		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end 

		def find_user
			@user = User.find(params[:id])
		end
end