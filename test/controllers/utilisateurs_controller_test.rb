require "test_helper"

class UtilisateursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get utilisateurs_index_url
    assert_response :success
  end

  test "should get show" do
    get utilisateurs_show_url
    assert_response :success
  end

  test "should get new" do
    get utilisateurs_new_url
    assert_response :success
  end

  test "should get edit" do
    get utilisateurs_edit_url
    assert_response :success
  end
end
