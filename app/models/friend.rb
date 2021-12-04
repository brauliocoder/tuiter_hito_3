class Friend < ApplicationRecord
  belongs_to :follower_user, foreign_key: 'user_id', class_name: 'User'
  belongs_to :followed_user, foreign_key: 'friend_id', class_name: 'User'

  validates :friend_id, uniqueness: true
  validates :user_id, uniqueness: true
end
