class ChangeExpediteurReferenceInEmails < ActiveRecord::Migration[7.2]
  def change
    remove_reference :emails, :expediteur, foreign_key: true
    add_reference :emails, :expediteur, null: false, foreign_key: { to_table: :utilisateurs }
  end
end
