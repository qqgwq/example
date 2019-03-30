class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  scope :range, ->(start_at, end_at){where("created_at >= ? and created_at <= ?", start_at, end_at)}

  def self.to_csv(users)
    CSV.generate do |csv|
      csv << ["name", "content", "email"]
      users.each do |user|
        csv << [user.name, user.content, user.email]
      end
    end
  end

  def tag_list
    tags.map(&:name).join(',')
  end

  def tag_list=(name)
    self.tags << Tag.where(name: name).first_or_create!
  end
end
