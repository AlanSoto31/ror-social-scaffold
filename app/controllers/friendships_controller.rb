class FriendshipsController < ApplicationController
  include FriendshipsHelper
    
    def index
      @friendships = Friendship.all
      @pending_friendships = Friendship.pending_friendships
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

    def update
      @friendship = Friendship.find(params[:id])

        if @friendship.update_attributes(friendship_params)
          redirect_to users_path
        else
          render 'edit'
        end
    end

    def destroy
      @friendship = Friendship.find(params[:id])
      @friendship.destroy
      redirect_to users_path
    end
        
end
