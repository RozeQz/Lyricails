require "application_system_test_case"
require 'selenium-webdriver'

class PostsTest < ApplicationSystemTestCase
  setup do
    @driver = Capybara.current_session.driver.browser
  end

  test 'checking app works vie selenium' do
    User.create(
      username: 'Test', email: 'test@example.com', 
      password: 'S1cret', password_confirmation: 'S1cret'
    )
    @driver.get(session_login_url)
    @driver.find_element(:id, 'username_path').click
    @driver.find_element(:id, 'username_path').send_keys('Test')
    @driver.find_element(:id, 'password_path').click
    @driver.find_element(:id, 'password_path').send_keys('S1cret')
    @driver.find_element(:id, 'submit-btn').click
    Selenium::WebDriver::Wait.new(timeout: 10).until { @driver.title.start_with? I18n.t('menu.home') }
    assert_redirected_to root_path
  end
end
