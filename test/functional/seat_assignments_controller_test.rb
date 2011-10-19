require 'test_helper'

class SeatAssignmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seat_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seat_assignment" do
    assert_difference('SeatAssignment.count') do
      post :create, :seat_assignment => { }
    end

    assert_redirected_to seat_assignment_path(assigns(:seat_assignment))
  end

  test "should show seat_assignment" do
    get :show, :id => seat_assignments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => seat_assignments(:one).to_param
    assert_response :success
  end

  test "should update seat_assignment" do
    put :update, :id => seat_assignments(:one).to_param, :seat_assignment => { }
    assert_redirected_to seat_assignment_path(assigns(:seat_assignment))
  end

  test "should destroy seat_assignment" do
    assert_difference('SeatAssignment.count', -1) do
      delete :destroy, :id => seat_assignments(:one).to_param
    end

    assert_redirected_to seat_assignments_path
  end
end
