class Utilisateur < ApplicationRecord
  has_secure_password
  has_many :emails, foreign_key: "expediteur_id", class_name: "Email" # Emails envoyés
  has_many :receptions # Emails reçus
  has_many :emails_recus, through: :receptions, source: :email

  validates :email, presence: true, uniqueness: true
end
