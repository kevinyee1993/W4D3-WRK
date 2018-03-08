class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to cats_url
    else
      render :new
    end
  end

  def create
    user = User.find_by_credentials(
     params[:user][:user_name],
     params[:user][:password]
   )

   if user.nil?
     # render json: 'Credentials were wrong'
     render :new
   else
     @user = true
     flash[:success] = "Welcome back #{user.user_name}!"
    user.reset_session_token
    login!(user)
    redirect_to cats_url
   end

  end


  def destroy
    @user = false
    logout!
    redirect_to new_session_url
  end
end
