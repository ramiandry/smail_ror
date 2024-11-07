class PiecesJointesController < ApplicationController
  before_action :set_email

  # Ajoute une pièce jointe à un email existant
  def create
    if params[:piece_jointe]
      params[:piece_jointe].each do |file|
        @email.pieces_jointes.attach(file)
      end
      redirect_to @email, notice: "Pièce(s) jointe(s) ajoutée(s) avec succès."
    else
      redirect_to @email, alert: "Aucun fichier sélectionné."
    end
  end

  # Supprime une pièce jointe spécifique
  def destroy
    piece_jointe = @email.pieces_jointes.find(params[:id])
    piece_jointe.purge # Supprime le fichier de la base de données et du stockage

    redirect_to @email, notice: "Pièce jointe supprimée avec succès."
  end

  private

  # Méthode pour définir l'email à partir de l'ID
  def set_email
    @email = Email.find(params[:email_id])
  end
end
