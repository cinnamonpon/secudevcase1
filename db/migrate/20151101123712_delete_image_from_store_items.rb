class DeleteImageFromStoreItems < ActiveRecord::Migration
  def change
    remove_column :store_items, :image
  end
end
