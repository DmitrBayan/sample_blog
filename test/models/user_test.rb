require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example Name", email: "example@mail.com",
                     password: "test123", password_confirmation: "test123")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "password shoule be present" do
    @user.password = @user.password_confirmation = "      "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "q" * 65
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "q" * 201 + "@mail.com"
    assert @user.valid?
  end

  test "password should not be too long" do
    @user.password = @user.password_confirmation = "a" * 65
    assert @user.valid?
  end

  test "password should not be too small" do
    @user.password = @user.password_confirmation = "a" * 6
    assert @user.valid?
  end

  test "email should have valid adress" do
    valid_adresses = %w[user@example.com
                        USER@foo.COM
                        A_US-ER@foo.bar.org
                        first.last@foo.jp
                        alice+bob@baz.cn]
    valid_adresses.each do |valid_adress|
      @user.email = valid_adress
      assert @user.valid?, "#{valid_adress.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
      duplicate_user = @user.dup
      @user.save
      assert_not duplicate_user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

   test "should follow and unfollow a user" do
    dmitry_tester = users(:dmitry_tester)
    vasya  = users(:vasya)
    assert dmitry_tester.following?(vasya)
    dmitry_tester.follow(vasya)
    assert dmitry_tester.following?(vasya)
    assert vasya.followers.include?(dmitry_tester)
    dmitry_tester.unfollow(vasya)
    assert_not dmitry_tester.following?(vasya)
  end

end
