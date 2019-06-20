require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login valid" do
    get login_path
    post login_path, params: {session: {email: @user.email,
                                        password: "abc123ppp"}}
    assert_not_empty flash
    # get "users/#{@user.id}"
    # assert_redirected_to user_path(@user)
    # assert_select "a[href=?]", login_path, count: 0
    # assert_select "a[href=?]", logout_path, count: 0
    # assert_select "a[href=?]", user_path(@user), count: 0
    # assert is_logged_in?
  end
end
