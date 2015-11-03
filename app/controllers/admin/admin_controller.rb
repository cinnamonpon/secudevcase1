class Admin::AdminController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  
  def index
    @orders = Order.paginate(:page => params[:page])
    @items = StoreItem.paginate(:page => params[:page])
    @donations = Donation.paginate(:page => params[:page])
  end
end
