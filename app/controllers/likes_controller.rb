class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_tweet
    before_action :find_like, only: [:destroy]

    def create
      if already_liked?
        flash[:notice] = "You can't like more than once"
      else
        @tweet.likes.create(user_id: current_user.id)
      end

      redirect_to tweets_path(@tweet)
    end

    def destroy
      if not already_liked?
        flash[:notice] = "Cannot unlike"
      else
        @like.destroy
      end
      
      redirect_to tweets_path(@tweet)
    end

    private
      def already_liked?
        Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
      end

      def find_tweet
        @tweet = Tweet.find(params[:tweet_id])
      end

      def find_like
        @like = @tweet.likes.find(params[:id])
      end
end
