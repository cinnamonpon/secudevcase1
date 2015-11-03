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
      redirect_to @order
    else
      flash.now[:danger] = "There was a problem placing your order. Please try again."
      render 'index'
    end
  end

  def add_item
    @items = StoreItem.paginate(:page => params[:page])
    item = StoreItem.find(params[:item_id])
    quantity = params[:quantity].to_f ||= 1
    begin
      @cart.add(item, item.price, quantity)
      flash.now[:success] = "Successfully added to cart."
    rescue => e
      flash.now[:danger] = "There was a problem adding to your cart. Try again."
    end

    redirect_to items_path
  end

  def clear
    @cart.clear
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