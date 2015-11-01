class AddStatusToStoreItem < ActiveRecord::Migration
  def change
    add_column :store_items, :status, :string
  end
end
