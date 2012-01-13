require 'test_helper'

class ThredsControllerTest < ActionController::TestCase
  setup do
    @thred = threds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:threds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thred" do
    assert_difference('Thred.count') do
      post :create, :thred => @thred.attributes
    end

    assert_redirected_to thred_path(assigns(:thred))
  end

  test "should show thred" do
    get :show, :id => @thred.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @thred.to_param
    assert_response :success
  end

  test "should update thred" do
    put :update, :id => @thred.to_param, :thred => @thred.attributes
    assert_redirected_to thred_path(assigns(:thred))
  end

  test "should destroy thred" do
    assert_difference('Thred.count', -1) do
      delete :destroy, :id => @thred.to_param
    end

    assert_redirected_to threds_path
  end
end
