require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
    def setup
        @user = users(:user)
        login(@user)
    end

    test "show all posts" do
        assert_text "Feed"
    end

    test "show current user's posts" do
        click_on "Wall"
        assert page.has_content?(@user.full_name)
    end

    test "add a new post" do
        click_on "Wall"
        click_on(class: "add-new")

        fill_in "Title", with: "First Post"
        fill_in "Description", with: "This is my first post."
        click_on "Create Toy"

        assert_text "First Post"
    end

    test "edit a post" do
        find(".fa-pen").click

        fill_in "Title", with: "Update Post"
        fill_in "Description", with: "This is my updated post."
        click_on "Update Toy"

        assert_text "Update Post"
    end

    test "delete a post" do
        page.accept_confirm do
         find(".fa-trash").click
        end
    end
end

