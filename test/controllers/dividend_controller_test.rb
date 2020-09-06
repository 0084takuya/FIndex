require 'test_helper'

class DividendControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dividend_index_url
    assert_response :success
  end

end
