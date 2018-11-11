require 'pry'
class FitnessGoalsController < ApplicationController
  
  # POST to '/fitness_goals/create
  def create
    if current_user.fitness_goals.empty?
      goal = FitnessGoal.new(whitelist_params)
      fitness_goal = CalculateCalories.new(current_user, goal).call

      if fitness_goal.save
        render json: { message: 'fitness goal added!' }
      else
        render json: { message: 'something went wrong'}
      end
    else
      render json: { message: 'You already have a fitness goal'}
    end
 
  end

  #when the user goes to edit their fitness goal on react, 
  #react makes a get request to pre-fill the current data based on what is output here:
  # GET to /fitness_goals/edit
  def edit
    if !current_user.fitness_goals.empty?
      fitness_goal = current_user.fitness_goals.first
      render( # we don't want them to be able to edit their user_id or any other important info.
        json: {
          fitness_goal: {
            current_age:      fitness_goal.current_age,
            current_weight:   fitness_goal.current_weight,
            current_height:   fitness_goal.current_height,
            gender:           fitness_goal.gender,
            activity_rating:  fitness_goal.activity_rating,
            desired_weight:   fitness_goal.desired_weight
          }
        }
      )
    else current_user.fitness_goals.empty?
      ender json: { message: 'please create a goal first.'}
    end 
  end

  # recalculate new values based on user's new info.
  # POST to fitness_goals/edit
  def update
    goal = current_user.fitness_goals.first

    if goal.update(whitelist_params)
      fitness_goal = CalculateCalories.new(current_user, goal).call
      if fitness_goal.save
        render json: { message: 'successfully updated fitness goal!' }
      else
        render json: { message: 'something went wrong'}
      end
    else
      render json: { message: 'something went wrong'}
    end
  end


  private
  def whitelist_params
    params.require(:fitness_goal).permit(
      :current_age, :current_weight, :gender, :current_height, 
      :activity_rating, :desired_weight, :current_calories
    )
  end

end