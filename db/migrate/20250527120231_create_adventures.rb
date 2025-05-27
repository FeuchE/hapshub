class CreateAdventures < ActiveRecord::Migration[7.1]
  def change
    create_table :adventures do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :image_url
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
