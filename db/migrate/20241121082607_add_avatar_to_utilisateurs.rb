class AddAvatarToUtilisateurs < ActiveRecord::Migration[7.2]
  def change
    add_column :utilisateurs, :avatar, :string
    add_column :utilisateurs, :tel, :string
    add_column :utilisateurs, :sexe, :boolean
    add_column :utilisateurs, :date_naissance, :date
    add_column :utilisateurs, :adresse, :string
  end
end
