class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships

  has_many :accepted_friendships, -> { where(status: true) }, class_name: 'Friendship'
  has_many :pending_friendships, -> { where(status: false) }, class_name: 'Friendship'
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_i_send_invite = Friendship.where(user_id: id, status: true).pluck(:friend_id)
    friends_i_got_invite = Friendship.where(friend_id: id, status: true).pluck(:user_id)
    friends_i_send_invite + friends_i_got_invite
  end
end
