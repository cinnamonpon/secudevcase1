class Cart < ActiveRecord::Base
  has_many :cart_items, :foreign_key => "owner_id"
  accepts_nested_attributes_for :cart_items

  acts_as_shopping_cart_using :cart_item
  validates :user_id, presence: true, uniqueness: true
  belongs_to :user

  def tax_pct
    0
  end

  def item_by_id(id)
    cart_items.where(item_id: id)
  end
end
