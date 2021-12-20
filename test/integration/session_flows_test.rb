# frozen_string_literal: true

require 'test_helper'

class SessionFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :posts

  test 'unauthorized user will be redirected to login page' do
    get users_path
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with incorrect credentials will be redirected to login page' do
    username = Faker::Internet.username
    email = Faker::Internet.email
    password = Faker::Internet.password
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    post session_create_url, params: { username: "#{user.username}d", password: "#{user.password}D" }
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with correct credentials will see the root' do
    username = Faker::Internet.username
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 6)
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    post session_create_url, params: { username: user.username, password: user.password }
    assert_redirected_to controller: :posts, action: :index
  end

  test 'user will see the root after signing up' do
    username = Faker::Internet.username
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 6)
    post users_path,
         params: { user: { username: username, email: email, password: password, password_confirmation: password } }
    assert_redirected_to user_url(User.last)
  end

  test 'user can logout' do
    username = Faker::Internet.username
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 6)
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    post session_create_url, params: { username: user.username, password: password }
    get session_logout_url
    assert_redirected_to controller: :session, action: :login
  end
end