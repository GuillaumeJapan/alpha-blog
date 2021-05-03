class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category #{@category.name} created"
      redirect_to categories_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(category_params)
      flash[:success] = "Category successfully updated"
      redirect_to categories_path
    else
      render :edit
    end
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 3)
  end
  
  private
    def category_params
      params.require(:category).permit(:name)
    end
    
    def set_category
      @category = Category.find(params[:id])
    end
    
    def require_admin
      if !logged_in? || !current_user.admin?
        flash[:danger] = "This action requires to be logged in with an admin account"
        redirect_to categories_path
      end
    end

end