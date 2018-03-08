class ApplicationController < ActionController::Base
   helper_method :current_user
  protect_from_forgery with: :exception


    def login!(user)
      @current_user = user
      session[:session_token] = user.session_token
    end

    def logout!
      current_user.try(:reset_session_token)
      session[:session_token] = nil
    end

    def current_user
      return nil if session[:session_token].nil?
      # @current_user ||= User.find_by_session_token(session[:session_token])
      @current_user ||= User.find_by(session[session_token: :session_token])
    end

end
