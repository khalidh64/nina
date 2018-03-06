require 'test_helper'

class PhysicalstockControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get physicalstock_index_url
    assert_response :success
  end

end
