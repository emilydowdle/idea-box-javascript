require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test "idea can be created" do
    count = idea_count

    idea = Idea.create!(title: "Title",
                        body: "Body")

    assert_equal Idea.last.title, idea.title
    assert_equal Idea.last.body, idea.body
    assert_equal Idea.last.id, idea.id
    assert_equal (count + 1), idea_count
  end

  test "idea can be created without body" do
    count = idea_count

    idea = Idea.create!(title: "Title")

    assert_equal Idea.last.title, idea.title
    assert_equal Idea.last.id, idea.id
    assert_equal (count + 1), idea_count
  end

  test "idea cannot be created without body" do
    count = idea_count

    idea = Idea.create(body: "Body")

    assert_equal count, idea_count
  end

  test "quality is defaulted to swill" do
    idea = Idea.create!(title: "Title",
                        body: "Body")

    assert_equal Idea.last.quality, "swill"
  end

  test "order returns correct information" do
    count = idea_count
    ideas = Idea.order

    assert_equal count, ideas.count
    assert_equal Idea.all.min.id, ideas.first.id
    assert_equal Idea.all.max.id, ideas.last.id
  end

  test "cap quality method works" do
    idea = Idea.first

    starting_quality = idea.quality
    ending_quality = idea.cap_quality

    assert_equal ending_quality, starting_quality.capitalize
  end

  def idea_count
    Idea.all.count
  end
end
