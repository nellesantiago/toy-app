require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def setup
    @user = users(:user)
    @admin = users(:admin)
    visit root_path
  end 

  test "log in with valid credentials" do
    login(@user)
    click_on "Settings"
    assert page.has_content?(@user.first_name)
  end

  test "log out" do
    login(@user)

    click_on "Log out"
    assert_text "Get Started"
  end

  test "create a new account" do
    click_on "Get Started"

    assert_text "Get started now."

    fill_in "First Name", with: "Rails"
    fill_in "Last Name", with: "Test"
    fill_in "Email Address", with: "rails@test.com"
    fill_in "Password (minimum 6 characters)", with: "123456"
    fill_in "Confirm Password", with: "123456"

    click_on "Sign up"

    assert_text "Feed"
  end

  test "edit account details" do
    login(@user)

    click_on "Settings"
    assert_text "Account Settings"
    
    fill_in "First name", with: "New"
    click_on "Save changes"
    click_on "Wall"

    assert_text "New"
  end

  test "delete account" do
    login(@user)

    click_on "Settings"
    
    page.accept_confirm do
      click_on "Continue to account deletion"
    end

    assert_text "Get Started"
  end

  test "log in as admin" do
    login(@admin)

    assert_text "Feed"
  end

  test "view all users" do
    login(@user)

    click_on "Users"
    assert_text "View Wall"
  end

  test "delete a user as an admin" do
    login(@admin)

    click_on "Users"

    page.accept_confirm do
      click_on "Delete User", match: :first
    end
  end
end
