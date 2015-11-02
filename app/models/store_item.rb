class StoreItem < ActiveRecord::Base
  has_many :orders
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" },                   :default_url => 'not_found.gif'

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than => 0  }
  validates_attachment_content_type :image, :content_type => /\Aimage\/(jpg|jpeg|pjpeg|png|x-png|gif)\Z/, :message => 'file type is not allowed'


  self.per_page = 15

end
