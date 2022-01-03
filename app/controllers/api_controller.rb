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
  
  def between_dates
    start = DateTime.strptime(params[:start], '%Y-%m-%d')
    final = DateTime.strptime(params[:final], '%Y-%m-%d')

    if start < final
      @tweet = Tweet.all
      array = []
      
      @tweet.each do |t|
        if t.created_at >= start && t.created_at <= final
          r = {
            id: t.id,
            content: t.content,
            user_id: t.user.id,
            like_count: t.likes.count,
            retweets_count: t.retweets.count,
            retwitted_from: t.retweet_id,
            retwitted_from: t.created_at
          }

          array.append(r)
        end
      end

      render json: array.to_json
    end
  end

  def create
    auth_header = request.headers["Authorization"].gsub("Basic ","")
    content = request.headers["Content"]
    decoded = Base64.decode64(auth_header).split(":")

    usr = decoded[0]
    pss = decoded[1]

    user = User.find_by(account: usr)
    if user
      if user.valid_password?(pss)
        t = Tweet.new
        t.content = content
        t.user_id = user.id
        t.save
      end
    end
  end
end
