class OrderItem < ActiveRecord::Base
  validates :order_id, presence: true
  validates :store_item_id, presence: true

  belongs_to :order
  belongs_to :store_item
end
