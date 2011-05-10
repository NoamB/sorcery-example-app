require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    User.delete_all
    @user = User.create!(email: 'whatever@whatever.com',
                         salt: "asdasdastr4325234324sdfds",
                         crypted_password: Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdastr4325234324sdfds"),
                         activation_state: "active")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {:email => "bla@pitput.com", :password => "gluplup", :password_confirmation => "gluplup"}
    end

    assert_redirected_to users_path
  end

  test "should show user" do
    login_user
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    login_user
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    login_user
    put :update, :id => @user.to_param, :user => @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    login_user
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to users_path
  end
end
