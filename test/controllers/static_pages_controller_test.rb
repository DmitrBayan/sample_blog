require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  #test for Home Page
  test "should get and root home" do
    get root_path
    assert_response :success
    assert_select "title", "*Home* Sample Blog"
  end

  #test for Help Page
  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "*Help* Sample Blog"
  end

  #test for About Page
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "*About* Sample Blog"
  end

  #test for Contact Page
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "*Contact* Sample Blog"
  end
end
