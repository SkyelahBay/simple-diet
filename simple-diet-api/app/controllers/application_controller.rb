class ApplicationController < ActionController::API
  # this is where I'm putting the authentication methods, since everything inherits from this controller it will have access to current_user.
  # when you are in api mode for rails 5 , tokens and sessions aren't included by default, so you have to add them back in.
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_user!
  
  def authenticate_user!
    # basically what devise's authenticate_user! does
    authenticate_token || render_error('access denied')
  end

  def current_user
    # if the user is logged in simply return that user, otherwise authenticate their token then return them. Every controller can now access the current_user.
    @current_user ||= authenticate_token
  end



  protected
  def render_error(message)
    errors = {
      errors: [detail: message]
    }

    render(
      json: errors,
      status: :unauthorized
    )
  end

  private
  def authenticate_token
    authenticate_with_http_token do |token, options| # rails gives this method.
  
        # the auth token is a field in the database WE create, and this method finds the user associated with that token, and returns that user.
        # this token is then provided later in the request header coming from a react fetch request to the API endpoint
      User.find_by(auth_token: token) # check the DB for a user
    end
  end

end
