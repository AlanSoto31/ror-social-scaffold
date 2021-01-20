# rubocop:disable Style/IdenticalConditionalBranches

class FriendshipsController < ApplicationController
  include FriendshipsHelper

  def index
    @friendships = Friendship.all
  end

  def create
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
      Friendship.create(user_id: @friendship.friend_id, friend_id: @friendship.user_id, status: true)
      redirect_to users_path
    else
      redirect_to users_path
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to users_path
  end
end

# rubocop:enable Style/IdenticalConditionalBranches
