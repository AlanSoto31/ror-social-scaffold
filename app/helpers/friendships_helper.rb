module FriendshipsHelper

  def friendship_params
    params.permit(:friend_id, :user_id, :status)  
  end
  
  # para imprimir el boton 'Add-friend' se tienen que cumplir:
    # 1.- Que no te puedas invitar a ti mismo
    # 2.- Que la invitacion no exista de ambos lados  
  def disappear_invite(usa_id, usa)
    @invite = nil
    if usa_id != current_user.id && !current_user.friendships.find_by(friend_id: usa_id) && !usa.friendships.find_by(friend_id: current_user.id)
      @invite = link_to 'Add friend', friendships_path(friend_id: usa_id, user_id: current_user.id, status: false), method: :post, class: 'btn btn-success'
    end
  end

  def answer_invitation(f_id)
    @accept = link_to 'Accept', friendship_path(id: f_id, status: true), method: :put, class: 'btn btn-success'
    @reject = link_to 'Reject', friendship_path(id: f_id), method: :delete, class: 'btn btn-success'
  end

  def recieved_friendships
    @recieved_friendships = Friendship.where(friend_id: current_user.id, status: false)
  end

  def cu_name
    if current_user
      @cu_name = current_user.name
    end
  end

end
