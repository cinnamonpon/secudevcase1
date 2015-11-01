class OrdersController < ApplicationController
  protect_from_forgery except: [:hook]

  def index
    @orders = Order.paginate(:page => params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      if params[:txn_type] == "cart"
        @order = Order.find params[:invoice]
        @user = @order.user

        @order.store_items.each_with_index do |s, i|
          if s.name.downcase.include?("donation")
            @user.build(amount: params["mc_gross_#{i}"], notification_params: params, status: status, transaction_id: params[:txn_id], paid_at: Time.now, order_ref: @order.id).save
          end
        end

        @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now

      elsif params[:txn_type] == "web_accept"
        @donation = Donation.find params[:invoice]
        @user = @donation.user
        @donation.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], paid_at: Time.now

      end
    end
    render nothing: true
  end

end
