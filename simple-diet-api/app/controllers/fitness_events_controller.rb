class FitnessEventsController < ApplicationController
  before_action :find_fitness_event, only: [:update, :destroy]

  def index
      fitness_events = current_user.fitness_events.all.map do |event|
        {
          id:                   event.id,
          event_title:          event.event_title,
          event_type:           event.event_type,
          event_duration:       event.event_duration,
          event_meal_occurence: event.event_meal_occurence,
          event_calories:       event.event_calories
        }
      end
      render json: { fitness_events: fitness_events }
  end

  def create
    event = FitnessEvent.new(fitness_event_params)
    fitness_event = CalculateNewCalories.new(current_user, current_user.fitness_goals.first, event).call

    if fitness_event.save
      render json: { message: 'Successfully added event' }
    else
      render json: { message: 'Something went wrong' }
    end
  end

  # POST to '/fitness_events/:id'
  def update
    if @fitness_event.update(fitness_event_params)
      render json: { message: 'Successfully updated event' }
    else
      render json: { message: 'Something went wrong' }
    end
  end

  def destroy
    @fitness_event.destroy
    render json: { message: 'Successfully removed event' }
  end



  private
  def fitness_event_params
    params.require(:event).permit(
      :event_title,
      :event_type,
      :event_duration,
      :event_meal_occurence,
      :event_calories
    )
  end

  def find_fitness_event
    @fitness_event = FitnessEvent.find(params[:id])
  end
end
