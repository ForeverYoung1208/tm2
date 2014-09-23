require 'test_helper'

class AordersControllerTest < ActionController::TestCase
  setup do
    @aorder = aorders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aorders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aorder" do
    assert_difference('Aorder.count') do
      post :create, :aorder => @aorder.attributes
    end

    assert_redirected_to aorder_path(assigns(:aorder))
  end

  test "should show aorder" do
    get :show, :id => @aorder.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @aorder.to_param
    assert_response :success
  end

  test "should update aorder" do
    put :update, :id => @aorder.to_param, :aorder => @aorder.attributes
    assert_redirected_to aorder_path(assigns(:aorder))
  end

  test "should destroy aorder" do
    assert_difference('Aorder.count', -1) do
      delete :destroy, :id => @aorder.to_param
    end

    assert_redirected_to aorders_path
  end
end
