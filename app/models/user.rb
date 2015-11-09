class User < ActiveRecord::Base
  before_save :default_role
  after_create :initialize_cart

  VALID_NAME_REGEX = /\A[a-zA-Z\s]+\Z/i
  VALID_USERNAME_REGEX = /\A[\w]+\Z/i
  validates :fname,  presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :lname,  presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :gender, presence: true, inclusion: { in: %w(Male Female)}
  validates :salutation, presence: true
  validates :birthdate, presence: true, inclusion: { in: Date.new(1900)..Time.now.years_ago(18).to_date }
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_USERNAME_REGEX }
  validates :about, presence: true

  has_many :posts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :donations, dependent: :destroy
  has_one  :cart, dependent: :destroy

  has_secure_password

  def full_name
    "#{fname} #{lname}"
  end

  def default_role
    self.role ||= 'user'
    if self.gender == "Male" && !%w(Mr Sir Senior Count).include?(self.salutation)
        errors.add(:salutation, "is invalid")
        false
    elsif self.gender == "Female" && !%w(Ms Miss Mrs Madame Majesty Seniora).include?(self.salutation)
        errors.add(:salutation, "is invalid")
        false
    end

  end

  def admin?
    if self.role == 'admin'
      return true
    end
  end

  def initialize_cart
    if !self.admin?
      c = Cart.create
      self.cart = c
    end
  end
end
