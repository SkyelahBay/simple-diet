class DashController < ApplicationController

  # this will display all of the user's current info
  # when they visit /dash on react side and react makes the fetch request to the api on heroku.
  def index
    fitness_goal = current_user.fitness_goals.first
    fitness_events = current_user.fitness_events.limit(5)
    
    render json: { 
      fitness_goal: fitness_goal,
      fitness_events: fitness_events
    }
  end

end
