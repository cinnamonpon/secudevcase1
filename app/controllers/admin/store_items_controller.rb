class Admin::StoreItemsController < AdminController

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
    @item = StoreItem.find params[:id]
  end

end
