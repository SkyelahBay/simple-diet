class CreateMetricsTables < ActiveRecord::Migration[5.2]
  def change
    create_table :metrics_tables do |t|
      t.belongs_to :user

      t.integer :total_calories_burned,   null: false, default: 0
      t.integer :total_calories_gained,   null: false, default: 0
      t.integer :record_calories_burned,  null: false, default: 0 # this gets updated only if an event tops it.
  
      t.timestamps
    end
  end
end
