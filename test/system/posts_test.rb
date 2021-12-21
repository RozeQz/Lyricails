require "application_system_test_case"
require 'selenium-webdriver'
require 'drb/drb'

class PostsTest < ApplicationSystemTestCase
  include SessionHelper

  setup do
    @driver = Capybara.current_session.driver.browser
    @user = User.create(
      username: 'Test', email: 'test@example.com', 
      password: 'S1cret', password_confirmation: 'S1cret'
    )
    # cookies[:remember_token] = nil
    sign_in @user
    # DRb.start_service()
  end

  test 'checking app works vie selenium' do
    @driver.get(session_login_url)
    @driver.find_element(:id, 'username_path').click
    @driver.find_element(:id, 'username_path').send_keys('Test')
    @driver.find_element(:id, 'password_path').click
    @driver.find_element(:id, 'password_path').send_keys('S1cret')
    @driver.find_element(:id, 'submit-btn').click
    
    Selenium::WebDriver::Wait.new(timeout: 100)
  end
end
