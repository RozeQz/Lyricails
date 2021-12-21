require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  include SessionHelper
  fixtures :users

  setup do
    @user = users(:one)
  end

  # test "should login user" do
  #   get session_login_path
  #   sign_in(@user)
  #   refute @user.nil?
  #   refute cookies.nil?
  # end

  test "should login user" do
    post session_create_path, params: { username: @user.username, password: @user.password }
    assert_redirected_to root_path
  end

  # test "should logout user" do
  #   get session_logout_path
  #   assert_redirected_to session_login_path
  # end

end
