class CartController < ApplicationController
  before_action :check_cart

  def index
    @cart_items = @cart.cart_items
  end

  def add_item
    @items = StoreItem.paginate(:page => params[:page])
    item = StoreItem.find(params[:item_id])
    quantity = params[:quantity] ||= 1
    if @cart.add(item, item.price, quantity)
      flash.now[:success] = "Successfully added to cart."
    else
      flash.now[:danger] = "There was a problem adding to your cart. Try again."
    end
    render 'store_items/index'
  end

  def clear
  end

  private

    def check_cart
      if !current_user.cart
        c = Cart.create
        current_user.cart = c
      end
      @cart = current_user.cart
    end
end
