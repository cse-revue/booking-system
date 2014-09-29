require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get reset" do
    get :reset
    assert_response :success
  end

  test "should get modify" do
    get :modify
    assert_response :success
  end

end
