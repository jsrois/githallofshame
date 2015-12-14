require 'test_helper'

class ReposControllerTest < ActionController::TestCase
  setup do
    @repo = repos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repos)
  end

  test "should show repo" do
    get :show, id: @repo
    assert_response :success
  end

end
