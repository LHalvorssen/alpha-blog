require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
   
    def setup
        @user = User.create(username: "heck", email: "heck@example.com", password: "password", admin: true)
    end

   test "get new_category_path" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
        post categories_path, params:{ category:{name: "sports", description: "blah blah baseball"}}
        follow_redirect!
        end
        assert_template 'categories/index'
        assert_match "sports", response.body
    end

    test "invalid categories submission results in failure" do
        sign_in_as(@user, "password")
        get new_category_path
        assert_template 'categories/new'
        assert_no_difference 'Category.count', 1 do
            post categories_path, params:{ category:{name: " ", description: " "}}
        end
        assert_template 'categories/new'
        assert_select "h2.panel-title"
        assert_select 'div.panel-body'
    end

end