require "test_helper"

class ReceptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get receptions_index_url
    assert_response :success
  end

  test "should get show" do
    get receptions_show_url
    assert_response :success
  end

  test "should get create" do
    get receptions_create_url
    assert_response :success
  end
end
