class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  scope :pending_friendships, -> { where(status: nil) }
end
