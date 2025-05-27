class AddAdventureIdToEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :adventure, foreign_key: true
  end
end
