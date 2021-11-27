class Tweet < ApplicationRecord  
  belongs_to :user

  belongs_to :retweet, class_name: "Tweet", optional: true
  has_many :tweet_references, class_name: "Tweet", foreign_key: "retweet_id"
end
