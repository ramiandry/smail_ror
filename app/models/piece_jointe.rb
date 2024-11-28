class PieceJointe < ApplicationRecord
  belongs_to :email

  validates :nom_fichier, presence: true
  validates :taille_fichier, numericality: { only_integer: true, greater_than: 0 }

  def teste
    p "ça marche !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end
end
