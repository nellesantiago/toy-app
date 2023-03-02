require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
    def setup
        @user = users(:user)
        login(@user)
    end

    test "show all current user posts" do
        assert_text "Hello"
    end

    test "add a new post" do
        click_on "Add Post"

        fill_in "Title", with: "First Post"
        fill_in "Description", with: "This is my first post."
        click_on "Create Post"

        assert_text "First Post"
    end

    test "edit a post" do
        click_on "Edit"

        fill_in "Title", with: "Update Post"
        fill_in "Description", with: "This is my updated post."
        click_on "Update Post"

        assert_text "Update Post"
    end

    test "delete a post" do
        page.accept_confirm do
         click_on "Delete"
        end

        assert_text "Hello"
    end
end

