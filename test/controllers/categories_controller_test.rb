require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "john", email: "john@example.com", password: "john", admin: true)
  end
  
  test "shoul get categories index" do
    get categories_path
    assert_response :success
  end
  
  test "shoul get new" do
    sign_in_as(@user, "john")
    get new_category_path
    assert_response :success
  end
  
  test "shoul get show" do
    get category_path(@category)
    assert_response :success
  end
  
  test "should redirect create when admin is not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: "books"}}
    end
    assert_redirected_to categories_path
  end
  
  test "should create when admin is logged in" do
    sign_in_as(@user, "john")
    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name: "books"}}
    end
    assert_redirected_to categories_path
  end
  
end
  