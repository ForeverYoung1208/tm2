require 'test_helper'

class AautosControllerTest < ActionController::TestCase
  setup do
    @aauto = aautos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aautos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aauto" do
    assert_difference('Aauto.count') do
      post :create, :aauto => @aauto.attributes
    end

    assert_redirected_to aauto_path(assigns(:aauto))
  end

  test "should show aauto" do
    get :show, :id => @aauto.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @aauto.to_param
    assert_response :success
  end

  test "should update aauto" do
    put :update, :id => @aauto.to_param, :aauto => @aauto.attributes
    assert_redirected_to aauto_path(assigns(:aauto))
  end

  test "should destroy aauto" do
    assert_difference('Aauto.count', -1) do
      delete :destroy, :id => @aauto.to_param
    end

    assert_redirected_to aautos_path
  end
end
