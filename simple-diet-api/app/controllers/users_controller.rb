require 'pry'

class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create] #for everything except registering.

  # POST to '/users'
  def create
    user = User.create!(user_params_for_create) #create with a bang directly returns the user instead of true or false.
    render json: { token: user.auth_token } #the auth_token is created when the user is created.
  end

  # GET to '/edit_profile
  def edit
    render json: {
      user_info: {
        name: current_user.name
        email: current_user.email
      }
    }
  end

  # POST to '/edit_profile
  def update
    new_data = user_params_for_update

    if current_user.authenticate(new_data[:current_password])
      if current_user.update(email: new_data[:email], password: new_data[:new_password], name: new_data[:name])
        render json: { message: 'profile updated!' }
      else
        render json: { message: 'something went wrong'}
      end
    else
      render json: { message: 'unauthorized'}
    end
  end

  # DELETE to '/delete_profile
  def destroy
    if current_user.authenticate(user_params_for_delete[:current_password])
      current_user.destroy 
      render json: { message: 'succesfully deleted profile'}
    else
      render json: { message: 'unauthorized'}
    end      
  end

  
  private
  def user_params_for_create
    params.require(:user).permit(:user_name, :password, :name, :email)
  end

  def user_params_for_update
    params.require(:user).permit(:current_password, :new_password, :name, :email)
  end

  def user_params_for_delete
    params.require(:user).permit(:current_password)
  end

end