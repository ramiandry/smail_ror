class Email < ApplicationRecord
  has_many_attached :pieces_jointes, dependent: :destroy
  belongs_to :expediteur, class_name: "Utilisateur"
  has_many :receptions, dependent: :destroy
  has_many :destinataires, through: :receptions, source: :utilisateur, dependent: :destroy

  validates :objet, presence: true
  validates :corps, presence: true
end
