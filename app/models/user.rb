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
    Friendship.where(user_id: id, status: true).pluck(:friend_id)
  end
end
