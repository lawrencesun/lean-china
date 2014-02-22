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
			flash[:success] = t('flash.user.create')
			redirect_to root_path
		else
		  render 'new'
		end
	end

	def show
		@posts = @user.posts.order('created_at DESC').page(params[:page]).per(10)

		respond_to do |format|
			format.html 	
			format.js
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = t('flash.user.update')
			redirect_to @user
		else
			render 'edit'
		end
	end 

	def destroy
		@user.destroy
		flash[:success] = t('flash.user.destroy')
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