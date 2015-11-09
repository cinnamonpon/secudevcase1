class SessionsController < ApplicationController
  skip_before_filter :logged_in_user, except: :destroy
  
  def new
    if logged_in?
      redirect_to root_url
    end
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      if !user
        flash.now[:danger] = "Username is not yet registered."
      else
        flash.now[:danger] = "Password is incorrect."
      end
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
