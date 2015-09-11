class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :gender
      t.string :salutation
      t.date :birthdate
      t.string :username
      t.string :about
      t.string :password_digest
      t.string :role

      t.timestamps null: false
    end
  end
end
