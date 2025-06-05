class AddStartAndEndDatetimeToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :start_datetime, :datetime
    add_column :events, :end_datetime, :datetime
  end
end
