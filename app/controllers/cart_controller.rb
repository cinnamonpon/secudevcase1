class CartController < ApplicationController
  before_action :check_cart

  def index
    @cart
    @cart_items = @cart.cart_items
  end

  def check_out
    @cart_items = @cart.cart_items

    @order = current_user.orders.build(amount: @cart.total, status: "Unpaid")

    if @order.save
      @cart_items.each do |c|
        @order.order_items.build(store_item_id: c.item.id, quantity: c.quantity).save
      end
      @cart.clear
      redirect_to @order.paypal_url(manage_order_path(@order))
    else
      flash.now[:danger] = "There was a problem placing your order. Please try again."
      render 'index'
    end
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
