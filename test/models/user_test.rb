# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  setup do
    @username = Faker::Internet.username
    @email = Faker::Internet.email
    @password = Faker::Internet.password
  end

  test 'check that empty input cannot be saved' do
    user = User.new
    refute user.save
  end

  test 'check that email should be valid' do
    user = User.new(username: @username, email: 'zxc', password: @password, password_confirmation: @password)
    refute user.save
  end

  test 'check that password should be complex' do
    user = User.new(username: @username, email: @email, password: '12345', password_confirmation: '12345')
    refute user.save
  end

  test 'check that password confirmation should match password' do
    user = User.new(username: @username, email: @email, password: @password, password_confirmation: '12345')
    refute user.save
  end

  test 'check that a user with correct credentials should be registered' do
    user = User.new(username: @username, email: @email, password: @password, password_confirmation: @password)
    assert user.save
    assert User.find_by(username: @username)
  end

  test 'check that a user with the existing username cannot be save' do
    user = User.new(username: users(:one).username, email: @email, password: @password,
                    password_confirmation: @password)
    refute user.save
  end

  test 'check that a user with the existing email cannot be save' do
    user = User.new(username: @username, email: users(:one).email, password: @password,
                    password_confirmation: @password)
    refute user.save
  end
end
