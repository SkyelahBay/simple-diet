class User < ApplicationRecord

  validates_uniqueness_of :user_name
  validates :email, presence: true
  validates :name,  presence: true
  has_secure_password                 # from bcrypt, handles encryption & decryption of password_digest.
  has_secure_token  :auth_token       # pass the column that should have the token in it.

  # invalidate_token is used for logging out, set the current_user's auth token to be nil.
  def invalidate_token
    self.update_columns(auth_token: nil)
  end

  # validate_login is used when logging in, it checks for a user that matches the requested credentials & returns that user if there is one.
  def self.validate_login(user_params)                        # note I whitelisted the params on the session_controller for extra security.
    user = find_by( user_name: user_params[:user_name] )
    user if user && user.authenticate(user_params[:password]) # bcrypt gives .authenticate
  end


  has_many :fitness_goals
  has_many :fitness_events
  has_many :metrics_tables
end
