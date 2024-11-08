class ReceptionsController < ApplicationController
  # Affiche toutes les réceptions
  def index
    @receptions = Reception.all
  end

  # Affiche une réception spécifique
  def show
    @reception = Reception.find(params[:id])
  end

  # Affiche le formulaire pour créer une nouvelle réception
  def new
    @reception = Reception.new
  end

  # Crée une nouvelle réception
  def create
    @reception = Reception.new(reception_params)
    if @reception.save
      redirect_to @reception, notice: "Réception créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Affiche le formulaire pour modifier une réception existante
  def edit
    @reception = Reception.find(params[:id])
  end

  # Met à jour une réception existante
  def update
    @reception = Reception.find(params[:id])
    if @reception.update(reception_params)
      redirect_to @reception, notice: "Réception mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Supprime une réception
  def destroy
    @reception = Reception.find(params[:id])
    @reception.destroy
    redirect_to receptions_path, notice: "Réception supprimée avec succès."
  end

  private

  # Paramètres sécurisés
  def reception_params
    params.require(:reception).permit(:utilisateur_id, :email_id)
  end
end
