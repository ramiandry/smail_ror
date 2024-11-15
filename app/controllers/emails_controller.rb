class EmailsController < ApplicationController
  layout "layout"
  before_action :authentifier_utilisateur!

  def index
    @emails = Email.all
  end

  def show
    @email = Email.find(params[:id])
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)

    # Recherche de l'expéditeur par email
    expediteur = Utilisateur.find_by(email: params[:email][:email])

    if expediteur
      # Si l'utilisateur est trouvé, ajouter son ID aux paramètres
      if @email.save
        reception=Reception.new({ utilisateur_id: expediteur.id, email_id: Email.last&.id })
        reception.save
      else
      render :new, status: :unprocessable_entity
      end
    else
      # Si l'utilisateur n'est pas trouvé, gérer l'erreur (par exemple, rediriger ou afficher un message d'erreur)
      flash[:alert] = "Utilisateur non trouvé avec l'email #{params[:email][:expediteur_id]}"
    end
    redirect_to root_path, notice: "Email envoyé avec succès."
  end

  def edit
    @email = Email.find(params[:id])
  end

  def update
    @email = Email.find(params[:id])
    if @email.update(email_params)
      redirect_to @email, notice: "Email mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to emails_path, notice: "Email supprimé avec succès."
  end

  private

  def email_params
    # Rechercher l'utilisateur par email
    params[:email][:expediteur_id]=session[:utilisateur_id]
    params.require(:email).permit(:objet, :corps, :date_envoi, :est_lu, :est_brouillon, :est_spam, :expediteur_id)
  end

  private
  # Méthode pour vérifier si un utilisateur est connecté
  def authentifier_utilisateur!
    unless utilisateur_connecte?
      redirect_to login_path, alert: "Vous devez être connecté pour accéder à cette page."
    end
  end
end
