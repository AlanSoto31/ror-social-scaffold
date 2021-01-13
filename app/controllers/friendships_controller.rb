class FriendshipsController < ApplicationController
  include FriendshipsHelper
    
    def index
      @friendships = Friendship.all
    end
  
    def create
      #@friendship = current_user.friendships.build(friendship_params)
      @friendship = Friendship.new(friendship_params)

      if @friendship.save
        redirect_to users_path
      else
        render 'new'
      end
    end
end
