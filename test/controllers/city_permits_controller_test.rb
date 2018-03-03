require 'test_helper'

class CityPermitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @city_permit = city_permits(:one)
  end

  test "should get index" do
    get city_permits_url
    assert_response :success
  end

  test "should get new" do
    get new_city_permit_url
    assert_response :success
  end

  test "should create city_permit" do
    assert_difference('CityPermit.count') do
      post city_permits_url, params: { city_permit: { plannumber: @city_permit.plannumber, propertyaddress: @city_permit.propertyaddress, reviewstatus: @city_permit.reviewstatus, reviewstatuschangeddate: @city_permit.reviewstatuschangeddate } }
    end

    assert_redirected_to city_permit_url(CityPermit.last)
  end

  test "should show city_permit" do
    get city_permit_url(@city_permit)
    assert_response :success
  end

  test "should get edit" do
    get edit_city_permit_url(@city_permit)
    assert_response :success
  end

  test "should update city_permit" do
    patch city_permit_url(@city_permit), params: { city_permit: { plannumber: @city_permit.plannumber, propertyaddress: @city_permit.propertyaddress, reviewstatus: @city_permit.reviewstatus, reviewstatuschangeddate: @city_permit.reviewstatuschangeddate } }
    assert_redirected_to city_permit_url(@city_permit)
  end

  test "should destroy city_permit" do
    assert_difference('CityPermit.count', -1) do
      delete city_permit_url(@city_permit)
    end

    assert_redirected_to city_permits_url
  end
end
