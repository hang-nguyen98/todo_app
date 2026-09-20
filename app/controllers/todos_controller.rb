class TodosController < ApplicationController
  before_action :require_login
  before_action :set_todo, only: %i[show edit update destroy]
  before_action :set_category_options, only: %i[new edit create update]

  # GET /todos
  def index
    @todos = current_user.todos.includes(:category)
  end

  # GET /todos/:id
  def show
    @todo = current_user.todos.includes(:category).find(params[:id])
  end

  # GET /todos/new
  # associate the new ToDo with the logged-in user so logged-in users can only create ToDos for themselves
  def new
    @todo = current_user.todos.build
  end

  # GET /todos/:id/edit
  def edit
    @todo = current_user.todos.includes(:category).find(params[:id])
  end

  # GET /todos/completed
  def completed
    @todos = current_user.todos.where(completed: true)
  end

  # POST /todos
  def create
    @todo = current_user.todos.build(todo_params)
    # make sure the logged-in user can only access their own categories
    @todo.category =
      current_user.categories.find(todo_params[:category_id])

    respond_to do |format|
      if @todo.save
        format.html {
          redirect_to @todo,
          notice: "Todo was successfully created."
        }

        format.json {
          render :show,
          status: :created,
          location: @todo
        }
      else
        format.html {
          render :new,
          status: :unprocessable_entity
        }

        format.json {
          render json: @todo.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # PATCH/PUT /todos/:id
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html {
          redirect_to @todo,
          notice: "Todo was successfully updated.",
          status: :see_other
        }

        format.json {
          render :show,
          status: :ok,
          location: @todo
        }
      else
        format.html {
          render :edit,
          status: :unprocessable_entity
        }

        format.json {
          render json: @todo.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html {
        redirect_to todos_path,
        notice: "Todo was successfully destroyed.",
        status: :see_other
      }

      format.json {
        head :no_content
      }
    end
  end

  private
    # make sure the logged-in user can only access their own Todos.
    def set_todo
      @todo = current_user.todos.find(params[:id])
    end

    def set_category_options
      @category_options = current_user.categories.collect do |category|
        [category.name, category.id]
      end
    end

    def todo_params
      params.require(:todo).permit(
        :title,
        :priority,
        :completed,
        :category_id
      )
    end
end