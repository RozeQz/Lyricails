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

  test 'user will see his page after signing up' do
    post users_path,
         params: { user: { username: @username, email: @email, password: @password, password_confirmation: @password } }
    assert_not_nil User.find_by(username: @username)
    assert_redirected_to user_url(User.last)
  end

  test 'users should be able to login' do
    post session_create_path, params: { username: users(:one).username, password: 'S1cret' }
    assert_redirected_to root_path
  end

  test 'unauthorized user should be able to logout' do
    post session_create_path, params: { username: users(:one).username, password: 'S1cret' }
    get session_logout_url
    assert_redirected_to controller: :session, action: :login
  end

  test 'user should be able to like posts' do
    post session_create_path, params: { username: users(:one).username, password: 'S1cret' }
    patch upvote_post_path(Post.last.id)
    assert_response :success
  end

  test 'user should be able to create posts' do
    title = "#{Faker::Music.band} #{Faker::Music::RockBand.song}"
    lyrics = Faker::Quote.famous_last_words
    post session_create_path, params: { username: users(:one).username, password: 'S1cret' }
    assert_difference('users(:one).posts.count') do
      post posts_path,
           params: { post: { title: title, lyrics: lyrics, user_id: users(:one).id,
                             music: fixture_file_upload('GunsNRoses - ThisILove.mp3', 'audio/mp3') } }
    end
    assert_response :found
  end

  test 'user should be able to delete posts' do
    post session_create_path, params: { username: users(:one).username, password: 'S1cret' }
    title = "#{Faker::Music.band} #{Faker::Music::RockBand.song}"
    lyrics = Faker::Quote.famous_last_words
    post posts_path,
         params: { post: { title: title, lyrics: lyrics, user_id: users(:one).id,
                           music: fixture_file_upload('GunsNRoses - ThisILove.mp3', 'audio/mp3') } }
    assert_changes('users(:one).posts.count') do
      delete post_path(Post.find_by(user_id: users(:one).id))
    end
  end

  test 'user should be able to edit himself' do
    post session_create_path, params: { username: users(:one).username, password: 'S1cret' }
    patch user_path(users(:one).id), params: { user: { username: 'newUserOne' } }
    assert_not_nil User.find_by(username: 'newUserOne')
  end

  test 'user should not be able to edit other users' do
    post session_create_path, params: { username: users(:one).username, password: 'S1cret' }
    patch user_path(users(:two).id), params: { user: { username: 'newUserTwo' } }
    assert_nil User.find_by(username: 'newUserTwo')
    assert_response :unprocessable_entity
  end
end
