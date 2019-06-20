require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid user signup" do
    get signup_path

    assert_difference "User.count", 1 do
      post signup_path, params: {
        user: {
          name: "dtvthe23",
          email: "dtvthe23@gmail.com",
          password: "abc123",
          password_confirmation: "abc123"
        }
      }
    end
    # assert_template "users/show"
    # assert_select "div#<CSS id for error explanation>"
    # assert_select "div.alert-success"
  end
end
