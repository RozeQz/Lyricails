ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # def sign_in(user)
  #   get session_login_path
  #   jar = ActionDispatch::Cookies::CookieJar.build(request, response.cookies)
  #   jar.signed[:user_id] = { value: user.id, expires: 2.days, http_only: true }
  #   @current_user = user
  #   p 'LOGIN'
  # end

  # def sign_out(user)
  #   get session_login_path
  #   jar = ActionDispatch::Cookies::CookieJar.build(request, response.cookies)
  #   jar.signed[:user_id] = nil
  #   @current_user = nil
  #   p 'LOGOUT'
  # end

end
