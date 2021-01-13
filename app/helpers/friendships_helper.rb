module FriendshipsHelper

  def friendship_params
    params.permit(:friend_id, :user_id)  
  end

  def send_invitation 
    @invite = link_to 'Add friend', friendships_path(friend_id: @user.id, user_id: current_user.id), method: :post, class: 'btn btn-success'
  end
end
