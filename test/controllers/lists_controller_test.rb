require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list = lists(:one)
    @task = tasks(:one)
  end

  test "should get index" do
    get lists_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_empty json_response
  end

  test "should create list" do
    assert_difference("List.count") do
      post lists_url, params: { list: { name: @list.name } }, as: :json
    end

    assert_response :created
  end

  test "should not create list with invalid name" do
    assert_no_difference('List.count') do
      post lists_url, params: { list: { name: '' } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show list" do
    get list_url(@list), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @list.id, json_response["id"]
    assert_not_nil json_response["tasks"]
  end

  test "should update list" do
    patch list_url(@list), params: { list: { name: @list.name } }, as: :json
    assert_response :success
  end

  test "should not update list with invalid name" do
    patch list_url(@list), params: { list: { name: '' } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy list" do
    assert_difference("List.count", -1) do
      delete list_url(@list), as: :json
    end

    assert_response :no_content
  end
end
