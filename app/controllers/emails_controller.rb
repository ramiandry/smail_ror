class EmailsController < ApplicationController
  layout "layout"
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
    if @email.save
      redirect_to @email, notice: "Email envoyé avec succès."
    else
      render :new, status: :unprocessable_entity
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

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to emails_path, notice: "Email supprimé avec succès."
  end

  private

  def email_params
    params.require(:email).permit(:objet, :corps, :date_envoi, :est_lu, :est_brouillon, :expediteur_id)
  end
end
class EmailsController < ApplicationController
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
    if @email.save
      redirect_to @email, notice: "Email envoyé avec succès."
    else
      render :new, status: :unprocessable_entity
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

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to emails_path, notice: "Email supprimé avec succès."
  end

  private

  def email_params
    params.require(:email).permit(:objet, :corps, :date_envoi, :est_lu, :est_brouillon, :expediteur_id)
  end
end
