class UsersController < ApplicationController
	before_action :require_user, only:[:edit, :update, :destroy]
	before_action :correct_user, only:[:edit, :update]
	before_action :find_user, only:[:show, :edit, :update, :destroy]
	before_action :admin_user, only: [:destroy, :index]

	def index
		@users = User.all
	end

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
		@posts = @user.posts.order('created_at DESC').page(params[:page]).per(10)
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

	def destroy
		@user.destroy
		flash[:success] = "删除用户."
		redirect_to users_path
	end


	private

		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end 

		def find_user
			@user = User.find_by_username(params[:id])
		end

		def correct_user
    	@user = User.find_by_username(params[:id])
    	redirect_to root_path unless correct_user?(@user)
  	end
end