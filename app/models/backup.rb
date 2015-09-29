class Backup < ActiveRecord::Base
  validates :filename, presence: true
end
