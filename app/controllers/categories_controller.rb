class CategoriesController < ApplicationController
  # requires the user to be logged in for all actions
  before_action :require_login
  # requires the set_category method to be called before the show, edit, update, and destroy actions
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  def index
    @categories = current_user.categories.includes(:todos)
  end

  # GET /categories/:id
  def show
    @todos = @category.todos  
  end

  # GET /categories/new
  def new
    @category = current_user.categories.build
  end

  def edit
  end

  # POST /categories
  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to @category, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/:id
  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # DELETE /categories/:id
  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Category was successfully destroyed."
  end

  private
    # helper method to permit only the name and description params from the category form
    def category_params
      params.require(:category).permit(:name, :description)
    end

    # make sure the logged-in user can only access their own categories
    def set_category
      @category = current_user.categories.find(params[:id])
    end

  
end