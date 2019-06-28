class CreateLunars < ActiveRecord::Migration[5.1]
  def change
    create_table :lunars do |t|
      t.text :date, array: true, default: []
      t.timestamps
    end
  end
end
s