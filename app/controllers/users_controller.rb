class UsersController < ApplicationController
  # requires the user to be logged in for the show, edit, update, and destroy actions
  before_action :require_login, only: %i[show edit update destroy]
  # requires the set_user method to be called before the show, edit, update, and destroy actions
  before_action :set_user, only: %i[show edit update destroy]
  
  # GET /signup
  def new
    @user = User.new
  end

  # GET /account
  def show
  end

  # GET /account/edit
  def edit
  end

  # POST /signup
  def create
    @user = User.new(user_params)

    if @user.save
      reset_session

      redirect_to root_path,
                  notice: "You have successfully signed up."
    else
      render :new, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /account
  def update
      if @user.update(user_params)
        redirect_to account_path, notice: "Your account was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity 
      end
    
  end


  # DELETE /account
  def destroy
    current_user.destroy!
    log_out

    redirect_to root_path,
                notice: "Your account has been successfully deleted.",
                status: :see_other
  end


  private
    # helper method to set the @user instance variable to the current_user
    def set_user
      @user = current_user
    end
    # helper method to permit only the 
    # first_name, last_name, username, email, password, and password_confirmation parameters from the user form
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name, 
        :username,
        :email,
        :password,
        :password_confirmation
      )
    end
end
