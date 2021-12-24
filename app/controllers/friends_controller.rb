class FriendsController < ApplicationController
  def follow
    @followed_user = User.find(params[:id])
    @relationship = current_user.active_relationships.new(friend_id: @followed_user.id)

    if @relationship.save
      redirect_back(fallback_location: root_path)
    end

  end
  
  def unfollow
    @relationship = Friend.find_by(user_id: current_user.id, friend_id: params[:id])

    if not @relationship.nil?
      @relationship.destroy
    end
    
    redirect_back(fallback_location: root_path)
  end

end
