class Donation < ActiveRecord::Base
  belongs_to :user

  self.per_page = 15

  def paypal_url(return_url)
    values = {
      :business => 'merchant@puastore.com',
      :cmd => '_donations',
      :upload => 1,
      :return => "#{Rails.application.secrets.app_host}#{return_url}",
      :invoice => id,
      :amount => amount,
      :currency_code => "USD",
      :item_name => "$#{amount} Donation",
      :image => "https://www.sandbox.paypal.com/en_US/i/btn/btn_donate_SM.gif",
      :quantity => '1',
      :notify_url => "#{Rails.application.secrets.app_host}/store/hook"
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
