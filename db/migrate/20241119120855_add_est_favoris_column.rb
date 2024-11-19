class AddEstFavorisColumn < ActiveRecord::Migration[7.2]
  def change
    add_column :emails, :est_favoris, :boolean
  end
end
