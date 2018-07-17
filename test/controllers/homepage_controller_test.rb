require 'test_helper'

class HomepageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get homepage_url
    assert_response :success
  end

end
