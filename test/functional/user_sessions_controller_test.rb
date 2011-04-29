require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:noam)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    login_user
    get :destroy
    assert_redirected_to :users
    assert_equal("Logged out!", flash[:notice])
  end

  test "when logged out should not get destroy" do
    logout_user
    get :destroy
    assert_redirected_to root_url
  end
end
