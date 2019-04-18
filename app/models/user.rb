class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  scope :range, ->(start_at, end_at){where("created_at >= ? and created_at <= ?", start_at, end_at)}
  enum status: { online: 0, left: 1 }

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

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
