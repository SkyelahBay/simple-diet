class CreateFitnessEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :fitness_events do |t|
      t.belongs_to :user

      t.string  :event_title,           null: false
      t.string  :event_type,            null: false
      t.integer :event_duration,        null: false, default: 0 # if type = exercise
      t.string  :event_meal_occurence,  null: false, default: 0
      t.integer :event_calories,        null: false, default: 0 # if type = meal

      t.timestamps
    end
  end
end
