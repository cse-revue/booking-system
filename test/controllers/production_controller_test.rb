require 'test_helper'

class ProductionControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get modify" do
    get :modify
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

end
