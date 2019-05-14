class Product < ApplicationRecord
  belongs_to :category
  ratyrate_rateable "speed", "engine", "price"
end
