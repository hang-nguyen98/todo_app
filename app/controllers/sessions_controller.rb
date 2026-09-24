class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  # authenticates the user based on the provided email and password, 
  # logs them in if valid, or re-renders the login form with an error message if invalid
  def create
    # find the user by email, ignoring case and whitespace
    user = User.find_by(email: session_params[:email].to_s.downcase.strip)

    # authenticate the user and log them in if the credentials are valid
    if user&.authenticate(session_params[:password])
      reset_session
      log_in(user)

      redirect_to todos_path, notice: "You have successfully logged in."
    else
      # display an error message and re-render the login form if the credentials are invalid
      flash.now[:danger] = "Invalid email or password. Try again."
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  # logs out the current user and redirects to the root path with a success message
  def destroy
    log_out
    redirect_to root_path, notice: "You have successfully logged out."
  end

  private
  # helper method to permit only the email and password parameters from the session form
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
