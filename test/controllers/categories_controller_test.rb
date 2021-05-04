require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "john", email: "john@example.com", password: "john", admin: true)
    @user2 = User.create(username: "rollo", email: "rollo@example.com", password: "rollo", admin: false)
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
  
  test "shoul get edit if logged as admin" do
    sign_in_as(@user, "john")
    get edit_category_path(@category)
    assert_response :success
  end
  
  test "shouldn't get edit if not logged as admin" do
    sign_in_as(@user2, "rollo")
    get edit_category_path(@category)
    assert_redirected_to categories_path
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
  
  test "should update when admin is logged in" do
    sign_in_as(@user, "john")
    patch category_path(@category), params: { category: { name: "books" } }
    assert_redirected_to categories_path
    # Reload association to fetch updated data and assert that title is updated.
    @category.reload
    assert_equal "books", @category.name
  end
  
end
  