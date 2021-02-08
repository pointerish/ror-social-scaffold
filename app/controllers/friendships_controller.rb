class FriendshipsController < ApplicationController
  
  def new
    @friendship = Friendship.new
  end
  
  def create
    @friendship = current_user.friendships.build(friendee_id: params[:user_id])
    @friendship.status = 'pending'
    if @friendship.save
      flash[:notice] = 'Friend request sent!'
      redirect_to root_url
    else
      redirect_to root_url, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.status = 'confirmed'

    if @friendship.save
      # @friendship.confirm_friend
      redirect_to user_path(current_user.id), notice: 'Friend request was successfully confirmed.'
    else
      redirect_to user_path(current_user.id), alert: @friendship.error.full_messages.join('. ').to_s
    end
  end

  def index
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
  end

  def destroy
    @friendship = Friendship.find_by(friendee_id: current_user.id, user_id: params[:user_id])

    if @friendship.destroy
      redirect_to user_path(current_user.id), notice: 'Friend request declined, we won\'t inform the user'
    else
      redirect_to user_path(current_user.id), alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end
end