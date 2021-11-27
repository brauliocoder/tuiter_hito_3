json.extract! tweet, :id, :content, :retweet_id, :user_id, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
