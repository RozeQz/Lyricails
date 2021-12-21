# frozen_string_literal: true

require 'test_helper'

class SessionFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :posts

  setup do
    @username = Faker::Internet.username
    @email = Faker::Internet.email
    @password = Faker::Internet.password(min_length: 6)
  end

  test 'unauthorized user can visit root path' do
    get root_path
    assert_response :success
  end

  test 'unauthorized user will be redirected to login page' do
    get users_path
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with incorrect credentials will be redirected to login page' do
    user = User.create(username: @username, email: @email, password: @password, password_confirmation: @password)
    post session_create_url, params: { username: "#{user.username}d", password: "#{user.password}D" }
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with correct credentials will see the root' do
    user = User.create(username: @username, email: @email, password: @password, password_confirmation: @password)
    post session_create_url, params: { username: user.username, password: user.password }
    assert_redirected_to controller: :posts, action: :index
  end

  test 'user will see the root after signing up' do
    post users_path,
         params: { user: { username: @username, email: @email, password: @password, password_confirmation: @password } }
    assert_redirected_to user_url(User.last)
  end

  test 'user can logout' do
    user = User.create(username: @username, email: @email, password: @password, password_confirmation: @password)
    post session_create_url, params: { username: user.username, password: user.password }
    get session_logout_url
    assert_redirected_to controller: :session, action: :login
  end

  test 'user can like posts' do
    user = User.create(username: @username, email: @email, password: @password, password_confirmation: @password)
    post session_create_url, params: { username: user.username, password: user.password }
    patch upvote_post_path(Post.last.id)
    assert_response :success
  end

  test 'user can create post' do
    user = User.create(username: @username, email: @email, password: @password, password_confirmation: @password)
    post session_create_url, params: { username: user.username, password: user.password }
    post posts_path, params: { post: { title: Faker::Music.band + " " + Faker::Music::RockBand.song, lyrics: Faker::Quote.famous_last_words, user_id: user.id, music: fixture_file_upload("GunsNRoses - ThisILove.mp3", "audio/mp3") } } 
    assert_response :found
  end
end