class StoreItemsController < ApplicationController
  before_action :user_access, only: :index
  before_action :check_cart

  def index
    @items = StoreItem.active.paginate(:page => params[:page])
    @cart_items = current_user.cart.cart_items
  end

  def show
    @item = StoreItem.find params[:id]
    @post = Post.new
    @cart_items = current_user.cart.cart_items
  end

  private

    def check_cart
      if !current_user.cart
        c = Cart.create
        current_user.cart = c
      end
    end


end
