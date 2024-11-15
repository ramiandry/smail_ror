class UpdatePasswordToUtilisateur < ActiveRecord::Migration[7.2]
  def change
    rename_column :utilisateurs, :mot_de_passe, :password_digest
  end
end
