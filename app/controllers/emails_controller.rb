class EmailsController < ApplicationController
  layout "layout"
  before_action :authentifier_utilisateur!

  def index
    @emails = Email.joins(receptions: :utilisateur)
    .where(utilisateur: { id: session[:utilisateur_id] })
    .where(est_spam: false, est_archiver: false)
    .order(created_at: :desc)
    .page(params[:page]).per(10)
  end

  def envoyer
    @emails = Email.joins(receptions: :utilisateur)
                .where(expediteur: session[:utilisateur_id])
                .order(created_at: :desc)
  end

  def search
    p params[:word]
    @users = Utilisateur.where("email LIKE ?", "%#{params[:word]}%")

    @emailrecus = Email.joins(receptions: :utilisateur)
    .where(utilisateur: { id: session[:utilisateur_id] })
    .where(est_spam: false, est_archiver: false)
    .where("emails.corps LIKE :word OR emails.objet LIKE :word", word: "%#{params[:word]}%") # Filtrage par email
    .order(created_at: :desc)

    @emailenvoyer = Email.joins(receptions: :utilisateur)
    .where(expediteur: session[:utilisateur_id])
    .where("emails.corps LIKE :word OR emails.objet LIKE :word", word: "%#{params[:word]}%") # Filtrage par email
    .order(created_at: :desc)
  end

  def show
    @email = Email.find(params[:id])
    @email.update(est_lu: true) unless @email.est_lu
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

        redirect_to root_path, notice: "Email envoyé avec succès."
      else
      render :new, status: :unprocessable_entity
      end
    else
    # Si l'utilisateur n'est pas trouvé, gérer l'erreur (par exemple, rediriger ou afficher un message d'erreur)
    flash[:alert] = "Utilisateur non trouvé avec l'email #{params[:email][:expediteur_id]}"
    end
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

  def archiver
    @email = Email.find(params[:id])
    new_status = !@email.est_archiver
    @email.update(est_archiver: new_status)
    status_message = new_status ? "archivé" : "désarchivé"
    redirect_to root_path, notice: "Email #{status_message} avec succès."
  end

  def spam
    @email = Email.find(params[:id])
    new_status = !@email.est_spam
    @email.update(est_spam: new_status)
    status_message = new_status ? "spam" : "non spam"
    redirect_to root_path, notice: "Email #{status_message} avec succès."
  end


  def favoris
  @email = Email.find(params[:id])
  new_status = !@email.est_favoris
  @email.update(est_favoris: new_status)
  status_message = new_status ? "favoris" : "non favoris"
  redirect_to root_path, notice: "Email #{status_message} avec succès."
  end

  def non_lu
    @email = Email.find(params[:id])
    new_status = false
    @email.update(est_lu: new_status)
    status_message = "non lu"
    redirect_to root_path, notice: "Email #{status_message} avec succès."
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to root_path, notice: "Email supprimé avec succès."
  end


  private

  def email_params
    # Rechercher l'utilisateur par email
    params[:email][:expediteur_id]=session[:utilisateur_id]
    params.require(:email).permit(:objet, :corps, :date_envoi, :est_lu, :est_brouillon, :est_spam, :expediteur_id, pieces_jointes: [])
  end

  private
  # Méthode pour vérifier si un utilisateur est connecté
  def authentifier_utilisateur!
    unless utilisateur_connecte?
      redirect_to login_path, alert: "Vous devez être connecté pour accéder à cette page."
    end
  end
end
