require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list = lists(:one)
    @task = tasks(:one)
  end

  test "should get index" do
    get list_tasks_url(@list), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_empty json_response
  end

  test "should create task" do
    assert_difference('Task.count') do
      post list_tasks_url(@list), params: { task: { text: 'New Task', completed: false } }, as: :json
    end

    assert_response :created
  end

  test "should not create task with invalid text" do
    assert_no_difference('Task.count') do
      post list_tasks_url(@list), params: { task: { text: '', completed: false } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show task" do
    get list_task_url(@list, @task), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @task.id, json_response["id"]
  end

  test "should update task" do
    patch list_task_url(@list, @task), params: { task: { text: 'Updated Task', completed: true } }, as: :json
    assert_response :success

    @task.reload
    assert_equal 'Updated Task', @task.text
    assert_equal true, @task.completed
  end

  test "should not update task with invalid text" do
    patch list_task_url(@list, @task), params: { task: { text: '' } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete list_task_url(@list, @task), as: :json
    end

    assert_response :no_content
  end
end
