class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show

    @user = User.find_by(username: params[:id])

  end

  def new
    #form for adding a new user
    @user = User.new
  end

  def create
    # take parameters from form
    # create a new user
    @user = User.new(form_params)

    # if it's valid and saves, go to list of Users
    #if not see form with errors

    if @user.save
      #save the session with the user
      session[:user_id]

      redirect_to users_path
    else
      render "new"
    end
  end

  def form_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
