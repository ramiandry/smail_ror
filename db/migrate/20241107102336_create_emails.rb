class CreateEmails < ActiveRecord::Migration[7.2]
  def change
    create_table :emails do |t|
      t.string :objet
      t.text :corps
      t.datetime :date_envoi
      t.boolean :est_lu
      t.boolean :est_brouillon
      t.boolean :est_spam
      t.references :expediteur, null: false, foreign_key: { to_table: :utilisateurs }

      t.timestamps
    end
  end
end
