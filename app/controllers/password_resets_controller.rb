class PasswordResetsController < ApplicationController
	
	def new
	end

	def create
		@user = User.find_by_email(params[:email])
		if @user
			@user.send_password_reset
			flash[:success] = t('flash.reset.email.success')
			redirect_to root_path
		else 
			flash.now[:error] =  t('flash.reset.email.error')
			render 'new'
		end
	end

	def edit
		@user = User.find_by_password_reset_token!(params[:id])
	end

	def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		flash[:error] = t('flash.reset.error')
    	redirect_to new_password_reset_path
  	elsif @user.update_attributes(params.permit![:user])
  		@user.update_attribute(:password_reset_token, nil)
  		flash[:success] = t('flash.reset.success')
    	redirect_to signin_path
  	else
    	render 'edit'
  	end
	end
end