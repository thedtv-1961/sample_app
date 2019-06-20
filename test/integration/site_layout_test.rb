require "test_helper"
require "rails-controller-testing"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout link" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", "/?locale=en", count: 2
    assert_select "a[href=?]", "/help?locale=en"
  end
end
