class User < ApplicationRecord
  before_save :set_default_picture
  PROFILE_PICTURE_DEFAULT = "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"

  # Tweets association
  has_many :tweets, dependent: :destroy

  # Follow association
  has_many :active_relationships, class_name: "Friend", foreign_key: "user_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Friend", foreign_key: "friend_id", dependent: :destroy

  has_many :followed_users, through: :active_relationships, source: :followed_user
  has_many :follower_users, through: :passive_relationships, source: :follower_user


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_default_picture
    if self.profile_picture.empty?
      self.profile_picture = PROFILE_PICTURE_DEFAULT
    end
  end
end
