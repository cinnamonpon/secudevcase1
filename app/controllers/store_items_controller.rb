class StoreItemsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:create, :new, :update, :destroy]

  def index
    @items = StoreItem.paginate(:page => params[:page])
    @cart_items = current_user.cart.cart_items
  end

  def show
    @item = StoreItem.find params[:id]
  end

  def new
    @item = StoreItem.new
  end

  def create
    @item = StoreItem.new(item_params)
    if @item.save
      flash[:success] = "Item was successfully added to your store."
      redirect_to 'manage'
    else
      render 'new'
    end
  end

  def edit
    @item = StoreItem.find params[:id]
  end

  def update
  end

  def manage
    @items = StoreItem.paginate(:page => params[:page])
  end

  private

    def item_params
      params.require(:store_item).permit(:name, :description, :price, :image)
    end
end
