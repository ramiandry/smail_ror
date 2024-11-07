class CreateUtilisateurs < ActiveRecord::Migration[7.2]
  def change
    create_table :utilisateurs do |t|
      t.string :nom
      t.string :email
      t.string :mot_de_passe

      t.timestamps
    end
  end
end
