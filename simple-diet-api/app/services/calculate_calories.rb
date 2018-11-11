require 'pry'

class CalculateCalories
  attr_reader :user, :goal, :recommended_calories

  def initialize(current_user, fitness_goal) # the fitness_goal has access to all the needed params.
    @user = current_user
    @goal = fitness_goal

    calculate_calories
  end


  def calculate_calories
    bmr = 0
    @recommended_calories = 0

    case  goal.gender
    when 'female'
      bmr = 655 + ( 4.35 * goal.current_weight ) + ( 4.7 * goal.current_height ) - ( 4.7 * goal.current_age )
    when 'male'
      bmr = 66 + ( 6.23 * goal.current_weight ) + ( 12.7 * goal.current_height ) - ( 6.8 * goal.current_age )
    end


    case goal.activity_rating
    when 1 
      @recommended_calories = bmr * 1.2
    when 2 
      @recommended_calories = bmr * 1.55
    when 3 
      @recommended_calories = bmr * 1.725
    end

    update_goal
  end
    

  def update_goal
    @goal.update(
      current_calories: goal.current_calories > 0 ? goal.current_calories : 0,
      recommended_calories: recommended_calories.round,
      user: user
    )
  end
    
  def call
    goal
  end
end