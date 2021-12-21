require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # include SessionHelper

  # setup do
  #   @user = users(:one)
  # end

  # test "should get index" do
  #   get session_login_path
  #   jar = ActionDispatch::Cookies::CookieJar.build(request, response.cookies)
  #   jar.signed[:user_id] = { value: @user.id, expires: 2.days, http_only: true }
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_user_url
  #   assert_response :success
  # end

  # test "should create user" do
  #   assert_difference('User.count') do
  #     post users_url, params: { user: { email: @user.email, last_login_at: @user.last_login_at, password: 'secret', password_confirmation: 'secret', username: @user.username } }
  #   end

  #   assert_redirected_to user_url(User.last)
  # end

  # test "should show user" do
  #   get user_url(@user)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_user_url(@user)
  #   assert_response :success
  # end

  # test "should update user" do
  #   patch user_url(@user), params: { user: { email: @user.email, last_login_at: @user.last_login_at, password: 'secret', password_confirmation: 'secret', username: @user.username } }
  #   assert_redirected_to user_url(@user)
  # end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user)
  #   end

  #   assert_redirected_to users_url
  # end
end
