class OrdersController < ApplicationController
  protect_from_forgery except: [:hook]

  def show
    @order = Order.find(params[:id])
  end
  
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @order = Order.find params[:invoice]
      @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    redirect_to @order
  end

end
