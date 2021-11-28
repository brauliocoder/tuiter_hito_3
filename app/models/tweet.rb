class Tweet < ApplicationRecord  
  # user reference
  belongs_to :user

  # recursive reference for retweet
  belongs_to :source, class_name: "Tweet", optional: true
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"

  # likes model association
  has_many :likes, dependent: :destroy
end
