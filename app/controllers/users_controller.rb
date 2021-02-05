class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def friends
    @friendships = User.find(current_user.id).friendships.where('status = true')
    @inverse_friends = User.find(current_user.id).inverse_friendships.where('status = true')
    @pending_invites= User.find(current_user.id).inverse_friendships.where('status = false')
    @pending_invites_by_me = User.find(current_user.id).friendships.where('status = false')
  end
end
