class AddScoreToRatings < ActiveRecord::Migration[5.1]
  def change
    add_column :ratings, :score, :integer
  end
end
