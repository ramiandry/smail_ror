class Email < ApplicationRecord
  has_many_attached :pieces_jointes
  belongs_to :expediteur, class_name: "Utilisateur"
  has_many :receptions
  has_many :destinataires, through: :receptions, source: :utilisateur

  validates :objet, presence: true
  validates :corps, presence: true
end
