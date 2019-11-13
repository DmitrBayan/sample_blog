require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path user: { name:  "",
                              email: "user@invalid",
                              password:              "123",
                              password_confirmation: "321" }
    end
    assert_template 'users/new'
    assert flash.empty?
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path user: { name:  "Example User",
                              email: "user@example.com",
                              password:              "password",
                              password_confirmation: "password" }
      follow_redirect!
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
