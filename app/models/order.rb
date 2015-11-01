class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :amount, presence: true, :numericality => { :greater_than => 0 }
  validates :status, presence: true

  has_many :store_items, through: :order_items
  has_many :order_items
  belongs_to :user

  self.per_page = 15

  serialize :notification_params, Hash

  def paypal_url(return_url)
    values = {
      :business => 'merchant@puastore.com',
      :cmd => '_cart',
      :upload => 1,
      :return => "#{Rails.application.secrets.app_host}#{return_url}",
      :invoice => id,
      :notify_url => "#{Rails.application.secrets.app_host}/store/hook"
    }
    order_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.store_item.price,
        "item_name_#{index+1}" => item.store_item.name,
        "item_number_#{index+1}" => item.store_item.id,
        "quantity_#{index+1}" => item.quantity
        })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
