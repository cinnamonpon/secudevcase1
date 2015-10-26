class OrderItem < ActiveRecord::Base
  validates :order_id, presence: true
  validates :item_id, presence: true
  
  belongs_to :order
  belongs_to :item
end
