class UpdateEmailsDefaultsAndRenameColumns < ActiveRecord::Migration[7.2]
  def change
    # Modifier la colonne `date_envoi` pour avoir une valeur par défaut de l'heure actuelle
    change_column_default :emails, :date_envoi, -> { 'CURRENT_TIMESTAMP' }

    # Définir des valeurs par défaut pour `est_lu`, `est_brouillon` et `est_spam`
    change_column_default :emails, :est_lu, from: nil, to: false
    change_column_default :emails, :est_brouillon, from: nil, to: false
    change_column_default :emails, :est_spam, from: nil, to: false

    # Renommer la colonne `est_brouillon` en `est_archiver`
    rename_column :emails, :est_brouillon, :est_archiver
  end
end
