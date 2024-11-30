class AddTransfertReception2 < ActiveRecord::Migration[7.2]
  def change
    add_reference :receptions, :transfert, foreign_key: { to_table: :utilisateurs }
  end
end
