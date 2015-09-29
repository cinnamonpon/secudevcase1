class CreateBackups < ActiveRecord::Migration
  def change
    create_table :backups do |t|
      t.string :filename

      t.timestamps null: false
    end
  end
end
