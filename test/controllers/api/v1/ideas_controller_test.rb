require "test_helper"

class Api::V1::IdeasControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "index returns the correct number of idea items" do
    get :index, format: :json

    assert_equal Idea.count, json_response.count
  end

  test "#index contains ideas that have the correct properties" do
    get :index, format: :json

    json_response.each do |idea|
      assert idea["id"]
      assert idea["title"]
      assert idea["body"]
      assert idea["quality"]
      assert idea["created_at"]
      assert idea["updated_at"]
    end
  end

  test "#show responds to json" do
    get :show, format: :json, symbolize_names: true, id: Idea.first

    assert_response :success
  end

  test "#show responds with 404 for wrong id" do
    last_id = Idea.last.id

    get :show, format: :json, symbolize_names: true, id: last_id + 1

    assert_response :success
    assert_equal ({"message"=>"Record not found"}), json_response
  end

  test "#show returns a record" do
    get :show, format: :json, symbolize_names: true, id: Idea.first

    assert_kind_of Hash, json_response
  end

  test "#show returns the correct idea item" do
    get :show, format: :json, symbolize_names: true, id: Idea.first

    assert_equal Idea.first.id, json_response["id"]
    assert_equal Idea.first.title, json_response["title"]
    assert_equal Idea.first.body, json_response["body"]
    assert_equal Idea.first.quality, json_response["quality"]
  end

  test "#create responds to json" do
    get :create, format: :json, symbolize_names: true, title: "Title", body: "Description"

    assert_response :success
  end

  test "#create adds a record" do
    starting_count = Idea.count

    get :create, format: :json, symbolize_names: true, title: "Title", body: "Description"

    assert_equal (starting_count + 1), Idea.count
  end

  test "#create does not add a record without title" do
    starting_count = Idea.count

    get :create, format: :json, symbolize_names: true, body: "Description"

    assert_response :success
    assert_equal starting_count, Idea.count
  end

  test "#create adds a record with the correct info" do
    starting_count = Idea.count

    get :create, format: :json, symbolize_names: true, title: "Title", body: "Description"

    assert_equal "Title", Idea.last.title
    assert_equal "Description", Idea.last.body
    assert_equal "swill", Idea.last.quality
  end

  test "#update responds to json" do
    get :update, format: :json, symbolize_names: true, id: Idea.last.id, title: "Title", body: "Description"

    assert_response :success
  end

  test "#update edits a record" do
    original = Idea.last

    get :update, format: :json, symbolize_names: true, id: Idea.last.id, title: "New Title", body: "New Description"

    refute_equal original.title, Idea.last.title
    refute_equal original.body, Idea.last.body
    assert_equal original.quality, Idea.last.quality
    assert_equal "New Title", Idea.last.title
    assert_equal "New Description", Idea.last.body
  end

  test "#update doesn't add an extra record" do
    starting_count = Idea.count

    get :update, format: :json, symbolize_names: true, id: Idea.last.id, title: "New Title", body: "New Description"

    assert_equal starting_count, Idea.count
  end

  test "#update saves old title correctly" do
    original_title = Idea.last.title
    original_body = Idea.last.body

    get :update, format: :json, symbolize_names: true, id: Idea.last.id, body: "New Description"

    assert_response :success
    assert_equal original_title, Idea.last.title
    refute_equal original_body, Idea.last.body
    assert_equal Idea.last.body, "New Description"
  end

  test "#destroy responds to json" do
    get :destroy, format: :json, symbolize_names: true, id: Idea.last.id

    assert_response :success
  end

  test "#destroy removes a record" do
    starting_count = Idea.count

    get :destroy, format: :json, symbolize_names: true, id: Idea.last.id

    assert_equal (starting_count - 1), Idea.count
  end

  test "#destroy removes the correct record" do
    original = Idea.last

    get :destroy, format: :json, symbolize_names: true, id: Idea.last.id

    refute_equal original.id, Idea.last.id
    refute_equal original.title, Idea.last.title
    refute_equal original.body, Idea.last.body
  end
end
