require "test_helper"

class PostTest < ActiveSupport::TestCase
    def setup
        @user = users(:user)
        @post = Post.new(title: "Toy", description: "New toy", user_id: @user.id)
    end

    test "post should have valid attributes" do
        assert @post.save
    end

    test "should have a title" do
        @post.title = nil
        assert_not @post.save
    end

    test "should have a description" do
        @post.description = nil
        assert_not @post.save
    end

    test "title should not exceed maximum of 20 characters" do
        @post.title = "abcdefghijklmnopqrstuvwxyz"
        assert_not @post.save
    end
end
