class CartItem < ActiveRecord::Base
  acts_as_shopping_cart_item_for :cart

  validates :quantity, presence: true, :numericality => { :greater_than => 0 }
  validates :owner_id, presence: true
  validates :owner_type, presence: true
  validates :item_id, presence: true
  validates :item_type, presence: true
  validates :price, presence: true, :numericality => { :greater_than => 0 }

  has_one :store_item
end
