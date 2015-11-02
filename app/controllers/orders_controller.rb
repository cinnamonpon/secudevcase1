class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show]

  before_action
  protect_from_forgery except: [:hook]

  def index
    @orders = current_user.orders.paginate(:page => params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed" && params[:secret] == APP_CONFIG[:paypal_secret]
      if params[:txn_type] == "cart"
        @order = Order.find params[:invoice]
        @user = @order.user

        @user.cart.clear

        @order.store_items.each_with_index do |s, i|
          if s.name.downcase.include?("donation")
            @user.build(amount: params["mc_gross_#{i}"], notification_params: params, status: status, transaction_id: params[:txn_id], paid_at: Time.now, order_ref: @order.id).save
          end
        end

        @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now

      elsif params[:txn_type] == "web_accept"
        @user = User.find params[:user_id]
        @user.build(amount: params["mc_gross_#{i}"], notification_params: params, status: status, transaction_id: params[:txn_id], paid_at: Time.now).save
      end
    end
    render nothing: true
  end

  private
  def correct_user
    order = current_user.orders.find_by(id: params[:id])
    if order.nil? || !current_user.admin?
      flash[:danger] = "Unauthorized access. Try again."
      redirect_to root_url
    end
  end
end
