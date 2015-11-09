class CartController < ApplicationController
  before_action :correct_user
  before_action :check_cart

  def show
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
      render 'show'
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

  def item_remove
    @cart
    @cart_items = @cart.cart_items
    quantity = Integer params[:quantity] rescue nil
    success = @cart.remove(StoreItem.find params[:id], quantity+1) rescue nil
    if success
      flash[:success] = "Item removed from your cart."
      render 'show'
    else
      flash[:danger] = "There was a problem updating your cart."
      render 'edit'
    end
  end

  def edit
    @cart
    @cart_items = @cart.cart_items
  end

  def update
    cart_items = params[:cart][:cart_items_attributes]
    success = "random"
    cart_items.each_with_index do |c, i|
      cart_item = CartItem.find cart_items["#{i}"][:id]
      quantity1 = cart_item.quantity
      quantity2 = Integer(cart_items["#{i}"][:quantity]) rescue nil

      if quantity2
        diff = quantity2 - quantity1
        if diff > 0
          success = @cart.add(cart_item.item, cart_item.item.price, diff) rescue nil
        elsif diff < 0
          diff.times do |i|
            success = @cart.remove(cart_item.item, diff) rescue nil
          end
        end
      end
      break if success == nil

      if success
        flash.now[:success] = "Successfully updated cart."
        render 'show'
      else
        flash[:danger] = "There was a problem updating your cart."
        render 'edit'
      end
    end

  end
  private

    def cart_params
      params.require(:cart).permit(:cart_items_attributes => [:quantity])
    end

    def check_cart
      if !current_user.cart
        c = Cart.create
        current_user.cart = c
      end
      @cart = current_user.cart
    end

    def correct_user
      if current_user.admin?
        flash[:danger] = "Please log in to your user account."
        redirect_to root_url
      end
    end
end
