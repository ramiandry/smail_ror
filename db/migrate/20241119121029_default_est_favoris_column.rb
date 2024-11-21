class DefaultEstFavorisColumn < ActiveRecord::Migration[7.2]
  def change
    change_column_default :emails, :est_favoris, from: nil, to: false
  end
end
