class OrdersController < ApplicationController
  skip_before_filter :logged_in_user, only: :hook
  before_action :user_access, only: :index
  before_action :correct_user, only: :show

  before_action
  protect_from_forgery except: [:hook]

  def index
    @orders = current_user.orders.paginate(:page => params[:page])
    @cart_items = current_user.cart.cart_items
  end

  def show
    @order = Order.find(params[:id])
  end

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if params[:secret] == APP_CONFIG[:paypal_secret]
      if params[:txn_type] == "cart"
        @order = Order.find params[:custom]
        @user = @order.user

        @order.store_items.each_with_index do |s, i|
          if s.name.downcase.include?("donation")
            amount = @order.store_items.count > 1 ? "mc_gross_#{i+1}" : "mc_gross"
              @user.donations.build(amount: params["#{amount}"], notification_params: params, status: status, transaction_id: params[:txn_id], paid_at: Time.now, order_ref: @order.id).save
          end
        end

        if @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
          @user.cart.clear
        end

      elsif params[:txn_type] == "web_accept"
        @user = User.find params[:custom]
        @user.donations.build(amount: params["mc_gross"], notification_params: params, status: status, transaction_id: params[:txn_id], paid_at: Time.now).save
      end
    end
    render nothing: true
  end

  def update
    order = Order.find params[:id]
    if order.update_attributes(status: "Cancelled")
      flash[:success] = "Your order is now cancelled."
      redirect_to order
    end
  end

  private

  def correct_user
    order = current_user.orders.find_by(id: params[:id])
    if order.nil? && !current_user.admin?
      flash[:danger] = "Unauthorized access. Try again."
      redirect_to root_url
    end
  end
end
