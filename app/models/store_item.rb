class StoreItem < ActiveRecord::Base
  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "200x200#" },                   :default_url => 'not_found.gif'

  has_many :order_items, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than => 0  }
  validates_attachment_content_type :image, :content_type => /\Aimage\/(jpg|jpeg|pjpeg|png|x-png|gif)\Z/, :message => 'file type is not allowed'
  validates :status, presence: true, inclusion: { in: ["Out of stock", "In stock", "Archived"] }


  self.per_page = 15


  def self.active
    where.not status: "Archived"
  end
end
