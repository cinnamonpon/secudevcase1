class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :amount, presence: true, :numericality => { :greater_than => 0 }
  validates :status, presence: true
  
  has_many :items, through: :order_items
end
