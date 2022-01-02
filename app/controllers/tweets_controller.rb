class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i[ show update destroy ]
  before_action :is_author?, only: %i[ destroy ]
  before_action :followed_users_ids, only: %i[ profile ]

  TWEETS_PER_PAGE = 50

  # GET /tweets or /tweets.json
  def index
    @page = params.fetch(:page, 0).to_i
    @pages = (Tweet.all.count / TWEETS_PER_PAGE.to_f).ceil
    
    # @tweets = Tweet.offset(@page * TWEETS_PER_PAGE).limit(TWEETS_PER_PAGE)
    @tweets = Tweet.search(params[:query])
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    if not params[:retweet_id].nil?
      @tweet = Tweet.new(retweet_id: params[:retweet_id])
    else
      @tweet = Tweet.new
    end
  end

  # POST /tweets
  def create
    @tweet = Tweet.new(tweet_params)
    
    if @tweet.save
      redirect_to root_path, notice: "Tweet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
    redirect_back(fallback_location: root_path)
  end

  def home
    @page = params.fetch(:page, 0).to_i
    @pages = (followed_users_ids.count / TWEETS_PER_PAGE.to_f).ceil

    @for_user_tweets = Tweet.tweets_for_me(followed_users_ids).offset(@page * TWEETS_PER_PAGE).limit(TWEETS_PER_PAGE)
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :retweet_id).merge(user: current_user)
    end

    def is_author?
      redirect_back(fallback_location: root_path) unless @tweet.user == current_user
    end

    def followed_users_ids
      ids = [current_user.id]
      current_user.followed_users.each do |user|
        ids.append(user.id)
      end

      return ids
    end
    
end
