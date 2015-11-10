class Admin::StoreItemsController < Admin::AdminController

  def new
    @item = StoreItem.new
  end

  def create
    @item = StoreItem.new(item_params)
    if @item.save
      flash[:success] = "Item was successfully added to your store."
      redirect_to admin_path, :anchor => 'tab_items'
    else
      render 'new'
    end
  end

  def edit
    @item = StoreItem.find params[:id]
  end

  def update
    @item = StoreItem.find params[:id]
    if @item.update_attributes(item_params)
      flash[:success] = "Store item #{@item.name} successfully updated"
      redirect_to admin_path, :anchor => 'tab_items'
    else
      render 'edit'
    end
  end

  def destroy
    item = StoreItem.find params[:id]
    if item.update_attributes(status: "Archived")
      flash[:success] = "Store item #{item.name} successfully archived."
    end
    redirect_to admin_path(:anchor => 'tab_items')
  end

  private

  def item_params
    params.require(:store_item).permit(:name, :description, :price, :image, :status)
  end

end
