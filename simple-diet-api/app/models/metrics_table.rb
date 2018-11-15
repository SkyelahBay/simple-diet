class MetricsTable < ApplicationRecord
  validates :total_calories_burned, presence: true
  validates :total_calories_gained, presence: true
  validates :record_calories_burned, presence: true

  belongs_to :user
end
