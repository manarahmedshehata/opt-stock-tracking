require 'test_helper'

class AssetControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get asset_add_url
    assert_response :success
  end

  test "should get update_price" do
    get asset_update_price_url
    assert_response :success
  end

  test "should get list" do
    get asset_list_url
    assert_response :success
  end

  test "should get get" do
    get asset_get_url
    assert_response :success
  end

end
