class Tweet < ApplicationRecord
  TIME_ZONE = "Santiago"
  validates :content, presence: true, length: {maximum: 280}

  # user reference
  belongs_to :user

  # recursive reference for retweet
  belongs_to :source, class_name: "Tweet", optional: true
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id", dependent: :destroy

  # likes model association
  has_many :likes, dependent: :destroy

  # SCOPES
  scope :tweets_for_me, -> (ff) { where(:user_id =>  ff)}
  
  def time_since_publish
    start_date = self.created_at.in_time_zone(TIME_ZONE)
    time_now = Time.now.in_time_zone(TIME_ZONE)

    t = time_now - start_date

    if t < 59.minutes
      mins = (t / 1.minute).round
      mins == 1 ? "#{mins} minuto" : "#{mins} minutos"
    else
      hours = (t / 1.hour).round
      hours == 1 ? "#{hours} hora" : "#{hours} horas"
    end
  end

  def self.search(search)
    if search
      where('lower(content) LIKE ?', "%#{search.downcase}%")
    else
      all
    end
  end
  
end
