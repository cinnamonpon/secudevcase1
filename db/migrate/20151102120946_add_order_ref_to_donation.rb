class AddOrderRefToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :order_ref, :integer
  end
end
