class CartItem < ActiveRecord::Base
  acts_as_shopping_cart_item_for :cart
  has_one :store_item
end
