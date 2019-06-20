require "test_helper"

class SessionsTest < ActionDispatch::IntegrationTest
  test "login valid" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {session: {email: "the@gmail.com", password: ""}}
    assert_template "sessions/new"
    assert_equal flash.empty?, false
    get root_path
    assert_not_empty flash
  end
end
