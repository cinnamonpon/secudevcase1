class Cart < ActiveRecord::Base
  acts_as_shopping_cart_using :cart_item
  belongs_to :user

  def paypal_url(return_url)
  values = {
    :business => 'merchant@puastore.com',
    :cmd => '_cart',
    :upload => 1,
    :return => return_url,
    :invoice => id
  }
  "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
end
end
