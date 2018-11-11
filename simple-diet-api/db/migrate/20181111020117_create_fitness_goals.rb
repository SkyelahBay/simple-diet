class CreateFitnessGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :fitness_goals do |t|
      t.belongs_to :user

      #these values get created upon fitness_goal create
      t.integer :current_age,           null: false            
      t.integer :current_weight,        null: false         
      t.integer :current_height,        null: false         
      t.string  :gender,                null: false                 
      t.integer :activity_rating,       null: false 

      # these require calculations.
      t.integer :desired_weight,        null: false         
      t.integer :current_calories,      null: false, default: 0       
      t.integer :recommended_calories,  null: false, default: 0  

      t.timestamps
    end
  end
end
