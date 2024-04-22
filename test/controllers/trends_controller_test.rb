require "test_helper"

class TrendsControllerTest < ActionDispatch::IntegrationTest
  test "should get twitter_search" do
    get trends_twitter_search_url
    assert_response :success
  end

  test "should get global_trends" do
    get trends_global_trends_url
    assert_response :success
  end

  test "should get search_location" do
    get trends_search_location_url
    assert_response :success
  end

  test "should get trends_updates" do
    get trends_trends_updates_url
    assert_response :success
  end
end
