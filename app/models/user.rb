class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :range, ->(start_at, end_at){where("created_at >= ? and created_at <= ?", start_at, end_at)}

  def self.to_csv(users)
    CSV.generate do |csv|
      csv << column_names
      users.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
