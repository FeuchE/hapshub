class AddPlaceIdToAdventures < ActiveRecord::Migration[7.1]
  def change
    add_column :adventures, :place_id, :string
    add_column :adventures, :photo_resource, :string
  end
end
