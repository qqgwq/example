class AddLikeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :like, :text, array: true, default: []
  end
end
