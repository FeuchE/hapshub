class AddImageUrlToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :image_url, :string
  end
end
