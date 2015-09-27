class Post < ActiveRecord::Base
  include PgSearch
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  self.per_page = 10

  pg_search_scope :advanced_search, :associated_against => {
    :user => :username
  }

  def self.find_substring(text)
    where('content LIKE ?', '%'+text+'%').all
  end
end
