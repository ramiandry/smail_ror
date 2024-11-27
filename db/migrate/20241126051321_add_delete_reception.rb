class AddDeleteReception < ActiveRecord::Migration[7.2]
  def change
    add_column :emails, :date_suppr, :date, default: nil
    add_column :receptions, :date_suppr, :date, default: nil
  end
end
