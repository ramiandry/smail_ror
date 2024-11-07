class CreatePieceJointes < ActiveRecord::Migration[7.2]
  def change
    create_table :piece_jointes do |t|
      t.string :nom_fichier
      t.integer :taille_fichier
      t.string :type_fichier
      t.references :email, null: false, foreign_key: true

      t.timestamps
    end
  end
end
