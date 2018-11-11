class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create], raise: false # since we don't need to authenticate them in order to CREATE a session.

  #this will be where all of the logic for logging in and out goes

  #POST to '/login'
  def create
    if user = User.validate_login(whitelist_params) # the user model has this method.
      create_session_token_for(user)
      send_token(user)
    end
  end

  #DELETE to '/logout'
  def destroy
    logout
    head :ok
  end



  private
  # for extra security, only allow the username and password through.
  def whitelist_params
    params.require(:user).permit(:user_name, :password)
  end

  #this creates a new auth token for the given user's auth field in the DB.
  def create_session_token_for(user)
    user.regenerate_auth_token  
  end

  def logout
    current_user.invalidate_token #the user model also has this method on it.
  end

  #this will send the token back to the client for use with future http requests.
  def send_token(user)
    render(
      json: {token: user.auth_token}
    )
  end
end
