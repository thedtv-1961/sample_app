require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    # User.new(name:"the", email:"the@gmail.com")
    @user = User.new name: "the", email: "the@gmail.com"
  end

  test "name's must be valid" do
    # @user.name = "sss"
    assert_not @user.valid?
  end

  test "email's must be valid" do
    # @user.email = "the@gmail.com"
    assert_not @user.valid?
  end

  test "email's must be unique" do
    duplidate_user = @user.dup
    duplidate_user.email = @user.email
    # assert @user.valid?
    @user.save
    assert_not duplidate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    # ERROR: test_email_addresses_should_be_saved_as_lower-case
    # mixed_case_email = "tHe@gmail.CoM"
    mixed_case_email = "the@gmail.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.email
  end

  test "add an user with password" do
    @user.password = "abc123"
    @user.password_confirmation = "abc123"
    assert @user.valid?
  end

  test "password's must more than 6 chars" do
    @user.password = "abc111"
    @user.password_confirmation = "abc111"
    assert @user.valid?
  end
end
