class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :accepted_friendships, -> { where(status: true) }, class_name: 'Friendship', dependent: :destroy
  has_many :pending_friendships, -> { where(status: false) }, class_name: 'Friendship', dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  def friends
    Friendship.where(user_id: id, status: true).pluck(:friend_id)
  end

  def list_friends
    ids = Friendship.where(user_id: id, status: true).pluck(:friend_id)
    User.where(id: ids)
  end

  def avatar
    email_address = email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    "https://www.gravatar.com/avatar/#{hash}"
  end
end
