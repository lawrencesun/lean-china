class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			if params[:remember_me]
				cookies.permanent[:remember_token] = user.remember_token
			else
				cookies[:remember_token] = user.remember_token
			end
			flash[:success] = t('flash.session.create.success') + ", #{params[:username]}."
			redirect_to root_path
		else
			flash.now[:error] = t('flash.session.create.error')
			render 'new'
		end
	end

	def destroy
		cookies.delete(:remember_token)
		flash[:success] = t('flash.session.destroy')
		redirect_to root_path
	end
end	