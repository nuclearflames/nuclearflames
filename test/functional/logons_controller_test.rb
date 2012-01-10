require 'test_helper'

class LogonsControllerTest < ActionController::TestCase
  test "should get logon" do
    get :logon
    assert_response :success
  end

  test "should get logoff" do
    get :logoff
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
