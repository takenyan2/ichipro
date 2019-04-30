require 'test_helper'

class MenusControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get menus_top_url
    assert_response :success
  end

  test "should get course" do
    get menus_course_url
    assert_response :success
  end

  test "should get access" do
    get menus_access_url
    assert_response :success
  end

  test "should get note" do
    get menus_note_url
    assert_response :success
  end

  test "should get add" do
    get menus_add_url
    assert_response :success
  end

  test "should get edit_menu" do
    get menus_edit_menu_url
    assert_response :success
  end

  test "should get index" do
    get menus_index_url
    assert_response :success
  end

  test "should get edit" do
    get menus_edit_url
    assert_response :success
  end

  test "should get create" do
    get menus_create_url
    assert_response :success
  end

  test "should get update" do
    get menus_update_url
    assert_response :success
  end

  test "should get destroy" do
    get menus_destroy_url
    assert_response :success
  end

  test "should get update_menu" do
    get menus_update_menu_url
    assert_response :success
  end

  test "should get delete_menu" do
    get menus_delete_menu_url
    assert_response :success
  end

end
