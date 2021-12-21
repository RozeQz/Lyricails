require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include SessionHelper

  setup do
    @user = users(:one)
  end

  test 'visiting the root path with a guest' do
    visit root_path
    assert_selector 'h1', text: 'Feed'
  end

  test 'redirect to root_path after login' do
    visit session_login_path
    fill_in 'username', with: users(:one).username
    fill_in 'password', with: 'secret'
    click_on 'submit-btn'
    sleep 2
    assert_selector 'h1', text: 'Feed'
  end

  test 'signed user can upload files' do
    visit session_login_path
    fill_in 'username', with: users(:one).username
    fill_in 'password', with: 'secret'
    click_on 'submit-btn'
    assert_difference('@user.posts.count') do
      click_on 'upload'
      fill_in 'title', with: posts(:one).title
      fill_in 'title', with: posts(:one).title
      attach_file 'file', 'test/fixtures/files/GunsNRoses - ThisILove.mp3'
      click_on 'submit-btn'
      sleep 1
    end
  end

  test 'signed user can like posts and see them in the collection' do
    visit session_login_path
    fill_in 'username', with: users(:one).username
    fill_in 'password', with: 'secret'
    click_on 'submit-btn'
    click_on 'upload'
    fill_in 'title', with: posts(:one).title
    fill_in 'title', with: posts(:one).title
    attach_file 'file', 'test/fixtures/files/GunsNRoses - ThisILove.mp3'
    click_on 'submit-btn'
    sleep 1
    find(".like-btn", match: :first).click
    sleep 1
    click_on 'collection_page'
    assert_selector '.track-name', text: posts(:one).title
  end

end
