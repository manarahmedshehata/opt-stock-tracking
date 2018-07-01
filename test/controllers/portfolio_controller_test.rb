require 'test_helper'

class PortfolioControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get portfolio_create_url
    assert_response :success
  end

  test "should get get" do
    get portfolio_get_url
    assert_response :success
  end

end
