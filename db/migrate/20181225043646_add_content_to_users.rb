class AddContentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :content, :text
  end
end
