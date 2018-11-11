class FitnessGoal < ApplicationRecord
  belongs_to :user
  
  validates :current_age,           presence: true            
  validates :current_weight,        presence: true         
  validates :current_height,        presence: true         
  validates :gender,                presence: true                 
  validates :activity_rating,       presence: true        
  validates :desired_weight,        presence: true
           
  validates :current_calories,      presence: true       
  validates :recommended_calories,  presence: true  
end
