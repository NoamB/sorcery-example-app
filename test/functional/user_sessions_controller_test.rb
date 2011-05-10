require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  setup do
    User.delete_all
    @user = User.create!(email: 'whatever@whatever.com',
                         salt: "asdasdastr4325234324sdfds",
                         crypted_password: Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdastr4325234324sdfds"),
                         activation_state: "active",
                         _type: "User")
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
