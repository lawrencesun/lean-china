class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = t('flash.session.create.success') + ", #{params[:username]}."
			redirect_to root_path
		else
			flash.now[:error] = t('flash.session.create.error')
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = t('flash.session.destroy')
		redirect_to root_path
	end
end	