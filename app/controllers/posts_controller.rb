class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @posts_to_display = display_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      @posts_to_display = display_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def display_posts
    timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
    friend_ids = []
    posts_to_display = []
    current_user.friendships.each do |f|
      friend_ids << f.friendee_id if f.status == 'confirmed'
    end
    current_user.inverse_friendships.each do |f|
      friend_ids << f.user_id if f.status == 'confirmed'
    end
    timeline_posts.each do |post|
      posts_to_display << post if friend_ids.include?(post.user_id) || post.user_id == current_user.id
    end
    posts_to_display
  end
end
