require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  # include SessionHelper
  # fixtures :users

  # setup do
  #   @user = users(:one)
  # end

  # test "should login user" do
  #   get session_login_path
  #   jar = ActionDispatch::Cookies::CookieJar.build(request, response.cookies)
  #   jar.signed[:user_id] = { value: @user.id, expires: 2.days, http_only: true }
  #   sign_in(@user)
  #   refute @user.nil?
  #   refute cookies.nil?
  # end

  # test "should logout user" do
  #   get session_logout_path
  #   assert_redirected_to session_login_path
  # end

end
