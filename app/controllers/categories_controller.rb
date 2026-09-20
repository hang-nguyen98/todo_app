class CategoriesController < ApplicationController
  before_action :require_login
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  def index
    @categories = current_user.categories
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
    @category = current_user.categories.find(params[:id])

  end

  # POST /categories
  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/:id
  def update
    @category = current_user.categories.find(params[:id])
    @description = @category.description
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # DELETE /categories/:id
  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy

    redirect_to categories_path, notice: "Category was successfully destroyed."
  end

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end

    def set_category_options
      @category_options = current_user.categories.pluck(:name, :id)
    end

    def set_category
      @category = current_user.categories.find(params[:id])
    end

  
end