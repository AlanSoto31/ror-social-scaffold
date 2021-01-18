require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid if all the fields are provided' do
    user = User.create(name: 'jeny', email: 'jenny@jenny.com', password: 'acambaro')
    expect(Post.create(content: 'Post description', user_id: user.id)).to be_valid
  end

  it 'only log-in users are able to create a post' do
    user = User.create(name: 'jeny', email: 'jenny@jenny.com', password: 'acambaro')
    expect(Post.create(content: 'Post description')).not_to be_valid
  end

end