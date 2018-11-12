class CalculateNewCalories
  attr_reader :user, :goal, :fitness_event, :new_calories

  def initialize(current_user, fitness_goal, fitness_event)
    @user = current_user
    @goal = fitness_goal
    @fitness_event = fitness_event
    @new_calories = 0

    if fitness_event.event_type == 'exercise'
      calculate_burned_calories 
    else
      calculate_added_calories
    end
  end


  def calculate_burned_calories
    #Total calories burned = Duration (in minutes)*(MET*3.5*weight in kg)/200
    burned_calories = fitness_event.event_duration * ( ((4 * 3.5) * (goal.current_weight * 2.205)) / 200)
    @new_calories = goal.current_calories - burned_calories

    update_goal_and_event
  end

  def calculate_added_calories
    @new_calories = goal.current_calories + fitness_event.event_calories
    update_goal_and_event
  end

  def update_goal_and_event
    @goal.update( current_calories: new_calories )
    @goal.save
    @fitness_event.update( user: user )
  end

  def call
    fitness_event
  end

end