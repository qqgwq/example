class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings, dependent: :destroy
  def is_star?(user)
    self.ratings.find_by_user_id(user)
  end
end
