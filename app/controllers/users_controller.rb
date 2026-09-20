class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit update destroy]

  # GET /signup
  def new
    @user = User.new
  end

  # GET /account
  def show
    @user = current_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/account/edit
  def edit
  end

  # POST /signup
  def create
    @user = User.new(user_params)

    if @user.save
      reset_session
      log_in @user

      redirect_to todos_path,
                  notice: "You have successfully signed up."
    else
      render :new, status: :unprocessable_entity
    end
  end
  # POST /users or /users.json
  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       reset_session
  #       log_in @user
  #       format.html { redirect_to @user, notice: "You have successfully signed up." }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
  # DELETE /users/1 or /users/1.json
  # def destroy
  #   current_user.destroy!
  #   log_out
  #   respond_to do |format|
  #     format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # def set_user 
    #   @user = User.find(params[:id])
    # end
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
