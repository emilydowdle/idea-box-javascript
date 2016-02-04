require 'test_helper'

class HomePageHTMLFrameworkTest < ActionDispatch::IntegrationTest

  test "path is correct" do
    visit '/'

    assert_equal root_path, current_path
  end

  test "input form displays" do
    visit '/'

    assert page.has_content? "Title:"
    assert page.has_css? "input#idea-title"
    assert page.has_content? "Body:"
    assert page.has_css? "input#idea-body"
    assert page.has_css? "input#create-idea"
  end

  test "search box displays" do
    visit '/'

    assert page.has_css? "input#idea_filter_title"
    assert page.has_content? "Search:"
  end
end
