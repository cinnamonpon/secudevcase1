class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.references :user, index: true, foreign_key: true
      t.float :amount

      t.timestamps null: false
    end
  end
end
