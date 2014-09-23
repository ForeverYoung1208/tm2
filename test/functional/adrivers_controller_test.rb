require 'test_helper'

class AdriversControllerTest < ActionController::TestCase
  setup do
    @adriver = adrivers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adrivers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adriver" do
    assert_difference('Adriver.count') do
      post :create, :adriver => @adriver.attributes
    end

    assert_redirected_to adriver_path(assigns(:adriver))
  end

  test "should show adriver" do
    get :show, :id => @adriver.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @adriver.to_param
    assert_response :success
  end

  test "should update adriver" do
    put :update, :id => @adriver.to_param, :adriver => @adriver.attributes
    assert_redirected_to adriver_path(assigns(:adriver))
  end

  test "should destroy adriver" do
    assert_difference('Adriver.count', -1) do
      delete :destroy, :id => @adriver.to_param
    end

    assert_redirected_to adrivers_path
  end
end
