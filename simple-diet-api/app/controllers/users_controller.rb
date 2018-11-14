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
        user_name: current_user.user_name,
        name: current_user.name,
        email: current_user.email
      }
    }
  end

  # POST to '/edit_profile
  def update
    new_data = user_params_for_update
 
    if current_user.authenticate(new_data[:current_password])
     
      # new_data[...params]
      if current_user.update(email: new_data[:email], name: new_data[:name], user_name: new_data[:user_name])
        render json: { message: 'profile updated!' }
      else
        render json: { 
          message: 'something went wrong, here is what rails tried to process, and each individual key',
          received_data: new_data,
          individual: {
            user_name: new_data[:user_name],
            name: new_data[:name],
            email: new_data[:email],
            current_password: new_data[:current_password]
          }
          
        }
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
    params.require(:user).permit(:current_password, :new_password, :name, :user_name, :email)
  end

  def user_params_for_delete
    params.require(:user).permit(:current_password)
  end

end


=begin {
  "user":{
    "name":"Alicia",
    "user_name":"SleepingPidgeon",
    "new_password":"31232",
    "current_password":"123123"
  }
}
=end