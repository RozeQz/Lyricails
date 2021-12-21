require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include SessionHelper

  setup do
    @post = posts(:one)
    @user = User.create(
      username: 'Test', email: 'test@example.com', 
      password: 'S1cret', password_confirmation: 'S1cret'
    )
    # cookies[:remember_token] = nil
    sign_in @user
  end

  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get new" do
    get new_post_path
    assert_response :success
  end

  test "should create post with correct params" do
    assert_difference('Post.count') do
      post posts_path, params: { post: { lyrics: @post.lyrics, title: @post.title, user_id: @post.user_id } }
    end

    assert_redirected_to root_path
  end

  test "should get edit" do
    get edit_post_path(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_path(@post), params: { post: { lyrics: @post.lyrics+'Updated', title: @post.title+'Updated', user_id: @post.user_id } }
    assert_redirected_to root_path
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_path(@post)
    end

    assert_redirected_to posts_url
  end
end
