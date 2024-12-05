class CreateBloquers < ActiveRecord::Migration[6.0]
  def change
    create_table :bloquers do |t|
      t.references :utilisateur, null: false, foreign_key: { to_table: :utilisateurs }
      t.references :bloquer, null: false, foreign_key: { to_table: :utilisateurs }
      t.timestamps
    end

    # Ajouter une contrainte d'unicité pour éviter les doublons
    add_index :bloquers, [ :utilisateur_id, :bloquer_id ], unique: true
  end
end
