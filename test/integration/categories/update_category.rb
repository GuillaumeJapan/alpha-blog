require "test_helper"

class UpdateCategoryTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "john", admin: true)
    @category = Category.create(name: "books")
  end
  
  test "get show category, edit category form and update category" do
    sign_in_as(@user, "john")
    get category_path(@category)
    assert_template "categories/show"
    get edit_category_path(@category)
    assert_template "categories/edit"
    patch category_path(@category), params: { category: { name: "sports" } }
    # Reload association to fetch updated data and assert that title is updated.
    @category.reload
    assert_equal "sports", @category.name
    assert_redirected_to categories_path
    follow_redirect!
    assert_template "categories/index"
    assert_select "div.alert-success"
  end
  
end