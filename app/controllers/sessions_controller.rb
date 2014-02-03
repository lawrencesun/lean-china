class SessionsController < ApplicationController
	before_action :get_categories

	def new
	end

	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "欢迎回来, #{params[:username]}."
			redirect_to root_path
		else
			flash.now[:error] = "用户名或密码错误."
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "退出成功."
		redirect_to root_path
	end
end	