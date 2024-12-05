class Utilisateur < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :emails, foreign_key: "expediteur_id", class_name: "Email" # Emails envoyés
  has_many :receptions # Emails reçus
  has_many :emails_recus, through: :receptions, source: :email
  has_many :receptions, foreign_key: "transferts_id"
  has_many :devices
  # Utilisateur peut avoir plusieurs utilisateurs bloqués
  has_many :bloqueurs, foreign_key: :utilisateur_id, class_name: "Bloquer"
  has_many :bloques, through: :bloqueurs, source: :bloquer


  validates :email, presence: true, uniqueness: true
end
