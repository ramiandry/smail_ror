class AddPrenomToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :utilisateurs, :prenom, :string
  end
end
