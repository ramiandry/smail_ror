class CreateDevices < ActiveRecord::Migration[7.2]
  def change
    create_table :devices do |t|
      t.references :utilisateur, null: false, foreign_key: true  # Remplacer t.integer :utilisateur_id par t.references
      t.string :systeme
      t.string :marque
      t.string :pays
      t.string :ip

      t.timestamps
    end
  end
end
