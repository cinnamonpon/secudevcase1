class UsersController < ApplicationController
  def new
    if !logged_in? || @current_user.admin?
      @user = User.new
    else
      redirect_to root_path
    end
  end

  def create
    if logged_in? && @current_user.admin?
      @user = User.new(admin_params)
    else
      @user = User.new(user_params)
    end

    if @user.save
        redirect_to root_path
     else
      render 'new'
    end
  end

  def edit

  end

  def show
    @user = User.find(params[:id])
  end

  private

    def admin_params
      params.require(:user).permit(:fname, :lname, :username, :password,
                                   :birthdate, :gender, :about, :role, :salutation)
    end

    def user_params
      params.require(:user).permit(:fname, :lname, :username, :password,
                                   :birthdate, :gender, :about, :salutation)
    end
end
