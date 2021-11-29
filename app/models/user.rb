class User < ApplicationRecord
  PROFILE_PICTURE_BY_DEFAULT = "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"

  has_many :tweets
  has_many :likes, dependent: :destroy

  before_save :set_default_picture
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_default_picture
    if self.profile_picture.empty?
      self.profile_picture = PROFILE_PICTURE_BY_DEFAULT
    end
  end
end
