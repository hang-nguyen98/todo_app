class TodosController < ApplicationController
  before_action :require_login
  # find all todos for the logged-in user
  before_action :set_todo, only: %i[show edit update destroy]
  # set the category options for the form dropdown
  before_action :set_category_options, only: %i[new edit create update]

  # GET /todos
  # displays a list of all ToDos for the logged-in user and includes their associated categories
  def index
    @todos = current_user.todos.includes(:category)
  end

  # GET /todos/:id
  # displays the details of a specific to-do for the logged-in user and includes its associated category
  def show
  end

  # GET /todos/new
  # associate the new to-do with the logged-in user so logged-in users can only create to-dos for themselves
  def new
    @todo = current_user.todos.build
  end

  # GET /todos/:id/edit
  def edit
  end

  # GET /todos/completed
  # displays a list of all completed ToDos for the logged-in user and includes their associated categories
  def completed
    @todos = current_user.todos.includes(:category).where(completed: true)
  end

  # POST /todos
  # creates a new to-do for the logged-in user and associates it with the selected category
  def create
    @todo = current_user.todos.build(todo_params)

    if @todo.save
      redirect_to @todo, notice: "Todo was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/:id
  # updates the attributes of a specific to-do for the logged-in user
  # if successful, redirects to the to-do's show page 
  # if unsuccessful, re-renders the edit form with an error message 
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /todos/:id
  # deletes a specific to-do for the logged-in user 
  # if successful, redirects to the list of all to-dos with a success message
  def destroy
    if @todo.destroy
      redirect_to todos_path,
      notice: "Todo was successfully destroyed.",
      status: :see_other
    else
      redirect_to todos_path,
      alert: "Todo could not be destroyed.",
      status: :unprocessable_entity
    end
  end

  private
    # make sure the logged-in user can only access their own to-dos
    def set_todo
      @todo = current_user.todos.includes(:category).find(params[:id])
    end

    # set the category options for the form dropdown
    def set_category_options
      @category_options = current_user.categories.collect do |category|
        [category.name, category.id]
      end
    end

    # helper method to permit only the title, priority, completed, and category_id parameters from the todo form
    def todo_params
      params.require(:todo).permit(
        :title,
        :priority,
        :completed,
        :category_id
      )
    end
end