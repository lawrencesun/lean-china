class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
  	!!current_user
  end

  def require_user
  	unless signed_in?
  		flash[:error] = "请登录."
  		redirect_to '/signin'
  	end
  end

  
end
