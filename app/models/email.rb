class Email < ApplicationRecord
  belongs_to :expediteur, class_name: 'Utilisateur'
  has_many :receptions
  has_many :destinataires, through: :receptions, source: :utilisateur
  has_many :pieces_jointes

  validates :objet, presence: true
  validates :corps, presence: true
end
