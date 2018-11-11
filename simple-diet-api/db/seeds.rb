require 'faker'

def calculate_calories(gender, age, height, weight, activity_rating)
  bmr = 0
  recommended_calories = 0

  case gender
  when 'female'
    bmr = 655 + ( 4.35 * weight ) + ( 4.7 * height ) - ( 4.7 * age )
  when 'male'
    bmr = 66 + ( 6.23 * weight ) + ( 12.7 * height ) - ( 6.8 * age )
  end

  case activity_rating
  when 1 # sedentary
    recommended_calories = bmr * 1.2
  when 2 # average
    recommended_calories = bmr * 1.55
  when 3 # very active
    recommended_calories = bmr * 1.725
  end

  recommended_calories.round
end


def calculate_burned_calories(duration, weight)
  #Total calories burned = Duration (in minutes)*(MET*3.5*weight in kg)/200
  burned_calories = duration * ( ((4 * 3.5) * (weight * 2.205)) / 200)
end

1.times do
  # make a user
  user = User.create!(
    user_name:  'alice',
    email:      Faker::Internet.unique.email,
    password:   '123123',  
    name:       Faker::Name.female_first_name
  )

  # give that user a fitness goal
  goal = FitnessGoal.new(
    user:                   user,
    current_age:            rand(18..50),
    current_weight:         rand(100..300),
    current_height:         rand(48..75),
    gender:                 ['male', 'female'].sample,
    activity_rating:        rand(1..3),
    desired_weight:         rand(120..180),
    current_calories:       rand(300..2000)
  )
  goal.update(
    recommended_calories:   calculate_calories(
      goal.gender, 
      goal.current_age, 
      goal.current_height, 
      goal.current_weight, 
      goal.activity_rating
    )
  )
  goal.save

  # add 3-7 fitness events for the user
  rand(3..7).times do 
    event_type = ['meal', 'exercise'].sample
    duration = event_type == 'exercise' ? rand(60..120) : 0
    FitnessEvent.create!(
      event_title:           event_type == 'meal' ? Faker::Food.dish : Faker::Team.sport,
      event_type:            event_type,
      event_duration:        duration,
      event_meal_occurence:  rand(Time.new.beginning_of_day..Time.new.end_of_day),
      event_calories:        event_type == 'meal' ? rand(200..500) : calculate_burned_calories(duration, goal.current_weight),
      user:                  user
    )
  end
end