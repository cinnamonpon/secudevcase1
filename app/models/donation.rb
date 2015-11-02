class Donation < ActiveRecord::Base
  belongs_to :user
  
  self.per_page = 15

  def self.paypal_encrypted(amount, user_id, return_url, notify_url)
    values = {
      :business => APP_CONFIG[:paypal_email],
      :cmd => '_donations',
      :upload => 1,
      :user_id => user_id,
      :return => return_url,
      :amount => amount,
      :currency_code => "USD",
      :item_name => "$#{amount} Donation",
      :image => "https://www.sandbox.paypal.com/en_US/i/btn/btn_donate_SM.gif",
      :quantity => '1',
      :notify_url => notify_url,
      :cert_id => APP_CONFIG[:paypal_cert_id]
    }
    self.encrypt_for_paypal(values)
  end

  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

  def self.encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
    end
end
