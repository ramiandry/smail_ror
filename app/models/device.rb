class Device < ApplicationRecord
  # Relations
  belongs_to :utilisateur

  validates :ip, presence: true, format: { with: Resolv::IPv4::Regex, message: "must be a valid IP address" }

  # Optionnel : Ajoutez des méthodes pour des fonctionnalités supplémentaires
end
