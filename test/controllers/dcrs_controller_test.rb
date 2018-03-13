require 'test_helper'

class DcrsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dcrs_index_url
    assert_response :success
  end

end
