class Admin::AdminController < ApplicationController
  def index
    @orders = Order.paginate(:page => params[:page])
    @items = StoreItem.paginate(:page => params[:page])
    @donations = Donation.paginate(:page => params[:page])
  end
end
