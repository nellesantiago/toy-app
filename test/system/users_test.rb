require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def setup
    @user = users(:user)
    @admin = users(:admin)
    visit root_path
  end 

  test "log in with valid credentials" do
    login(@user)

    assert page.has_content?(@user.first_name)
  end

  test "log out" do
    login(@user)
    assert page.has_content?(@user.first_name)

    click_on "Log out"
    assert_text "Home Page"
  end

  test "create a new account" do
    click_on "Sign up"

    assert_text "Register"

    fill_in "First Name", with: "Rails"
    fill_in "Last Name", with: "Test"
    fill_in "Email Address", with: "rails@test.com"
    fill_in "Password (minimum 6 characters)", with: "123456"
    fill_in "Confirm Password", with: "123456"

    click_on "Create User"

    visit root_path

    assert_text "Home Page"

    fill_in "Email", with: "rails@test.com"
    fill_in "Password", with: "123456"
    click_on "Log in"

    assert_text "Rails"
  end

  test "edit account details" do
    login(@user)

    click_on "Settings"
    assert_text "Edit Account Details"
    
    fill_in "First name", with: "New"
    click_on "Save changes"

    assert_text "New"
  end

  test "delete account" do
    login(@user)

    click_on "Settings"
    
    page.accept_confirm do
      click_on "Delete Account"
    end

    assert_text "Home Page"
  end

  test "log in as admin" do
    login(@admin)

    assert_text "Admin Dashboard"
  end
end
