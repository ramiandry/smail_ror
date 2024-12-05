class Bloquer < ApplicationRecord
  belongs_to :utilisateur, class_name: "Utilisateur"
  belongs_to :bloquer, class_name: "Utilisateur"

  # Validation pour éviter les doublons
  validates :utilisateur_id, uniqueness: { scope: :bloquer_id, message: "Cet utilisateur est déjà bloqué." }
end
