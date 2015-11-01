class AddPaperclipToPost < ActiveRecord::Migration
  def change
    add_attachment :store_items, :image  
  end
end
