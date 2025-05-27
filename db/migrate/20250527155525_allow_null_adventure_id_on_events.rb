class AllowNullAdventureIdOnEvents < ActiveRecord::Migration[7.1]
  def change
    change_column_null :events, :adventure_id, true
  end
end
