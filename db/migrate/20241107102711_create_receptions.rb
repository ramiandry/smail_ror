class CreateReceptions < ActiveRecord::Migration[7.2]
  def change
    create_table :receptions do |t|
      t.references :utilisateur, null: false, foreign_key: true
      t.references :email, null: false, foreign_key: true

      t.timestamps
    end
  end
end
