class FriendsController < ApplicationController
  def follow
    @followed_user = User.find(params[:id])
    @relationship = current_user.active_relationships.new(friend_id: @followed_user.id)

    if @relationship.save
      redirect_to root_path
    end

  end
  
  def unfollow
    @user_follows =  Friend.where(user_id: current_user.id)
    @relationship = @user_follows.find_by(friend_id: params[:id])

    if not @relationship.nil?
      @relationship.destroy
    end
    
    redirect_to root_path
  end

end
