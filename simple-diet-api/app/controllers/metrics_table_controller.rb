class MetricsTableController < ApplicationController
  def index
    render json: {
      metrics: {
        total_calories_burned: current_user.metrics_table.first.total_calories_burned
        total_calories_gained: current_user.metrics_table.first.total_calories_gained
        record_calories_burned: current_user.metrics_table.first.record_calories_burned
      }
    }
  end
end
