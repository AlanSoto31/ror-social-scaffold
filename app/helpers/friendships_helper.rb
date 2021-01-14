module FriendshipsHelper

  def friendship_params
    params.permit(:friend_id, :user_id, :status)  
  end

  def send_invitation 
    @invite = link_to 'Add friend', friendships_path(friend_id: @user.id, user_id: current_user.id, status: false), method: :post, class: 'btn btn-success'
  end

  def accept
    @invite = link_to 'Add friend', friendships_path(friend_id: @user.id, user_id: current_user.id, status: false), method: :post, class: 'btn btn-success'
  end

  def recieved_friendships
    @recieved_friendships = Friendship.where(friend_id: current_user.id, status: false)
  end
end
