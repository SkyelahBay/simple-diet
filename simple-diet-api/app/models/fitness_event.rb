class FitnessEvent < ApplicationRecord
  belongs_to :user

  validates :event_title,           presence: true
  validates :event_type,            presence: true
  validates :event_duration,        presence: true
  validates :event_meal_occurence,  presence: true
  validates :event_calories,        presence: true
end
