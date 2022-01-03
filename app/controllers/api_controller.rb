class ApiController < ApplicationController
  def news
    @tweet = Tweet.limit(50)

    array = []
    @tweet.reverse.each do |t|
      r = {
        id: t.id,
        content: t.content,
        user_id: t.user.id,
        like_count: t.likes.count,
        retweets_count: t.retweets.count,
        retwitted_from: t.retweet_id
      }

      array.append(r)
    end

    render json: array.to_json
  end
  
end
