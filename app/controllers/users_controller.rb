class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]

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

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @orders = @user.orders
    @donations = @user.donations

    @order_amount = 0
    @orders.each do |order|
      @order_amount = order.amount + @order_amount
    end

    @donation_amount = 0
    @donations.each do |order|
      @donation_amount = order.amount + @donation_amount
    end
 end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
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

    def update_params
      params.require(:user).permit(:fname, :lname, :password,
                                   :birthdate, :gender, :about, :salutation)
    end

    def correct_user
      @user = User.find params[:id]
      if current_user != @user || !current_user.admin?
        flash[:danger] = "Unauthorized access. Try again."
				redirect_to root_url
			end
   end
end
