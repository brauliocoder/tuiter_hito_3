class Friend < ApplicationRecord
  belongs_to :follower_user, foreign_key: 'user_id', class_name: 'User'
  belongs_to :followed_user, foreign_key: 'friend_id', class_name: 'User'
end
