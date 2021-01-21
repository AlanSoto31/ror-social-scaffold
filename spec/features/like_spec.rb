require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid if all the fields are provided' do
    user = User.create(name: 'jeny', email: 'jenny@jenny.com', password: 'acambaro')
    post = Post.create(content: 'Post description', user_id: user.id)
    expect(Like.create(post_id: post.id, user_id: user.id)).to be_valid
  end

  it 'User must exist' do
    user = User.create(name: 'jeny', email: 'jenny@jenny.com', password: 'acambaro')
    post = Post.create(content: 'Post description', user_id: user.id)
    expect(Like.create(post_id: post.id)).not_to be_valid
  end

  it 'Post must exist' do
    user = User.create(name: 'jeny', email: 'jenny@jenny.com', password: 'acambaro')
    expect(Like.create(user_id: user.id)).not_to be_valid
  end
end
