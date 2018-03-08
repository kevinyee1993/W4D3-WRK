class UsersController < ApplicationController

  def new
    if current_user
      redirect_to cats_url
    else
      render :new
    end
  end

  def create
     @user = User.new(user_params)
    #
    if @user.save
      flash[:success] = "You have logged on!"
      login!(@user)
      redirect_to cats_url
    else
      # render json: "Hello"
      render json: @user.errors.full_messages
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
