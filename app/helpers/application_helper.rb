module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friendship_behavior(user)
    friendship = Friendship.find_by(friendee_id: user.id, user_id: current_user.id, status: 'confirmed')
    inverse_friendship = Friendship.find_by(user_id: user.id, friendee_id: current_user.id, status: 'confirmed')
    pending_to_me = Friendship.find_by(friendee_id: current_user.id, user_id: user.id, status: 'pending')
    pending_by_me = Friendship.find_by(user_id: current_user.id, friendee_id: user.id, status: 'pending')
    if user.id == current_user.id
      content_tag :div, "This is you!", class: 'profile-link'
    elsif friendship
      content_tag :div, "You're already friends!", class: 'errors'
    elsif inverse_friendship
      content_tag :div, "You're already friends!", class: 'errors'
    elsif pending_by_me
      content_tag :div, "You already sent a friend request to this user.", class: 'errors'
    elsif pending_to_me
      render partial: 'friendships/decline', locals: { request: user }
    else
      render partial: 'addfriend', locals: { user: user }
    end
  end
end
