class SessionsController < ApplicationController
  require "device_detector"
  def create
    utilisateur = Utilisateur.find_by(email: params[:email])
    if utilisateur&.authenticate(params[:password_digest])
      session[:utilisateur_id] = utilisateur.id  # Créer la session pour l'utilisateur
      session[:utilisateur_nom] = utilisateur.nom  # Créer la session pour l'utilisateur
      session[:utilisateur_prenom] = utilisateur.prenom  # Créer la session pour l'utilisateur
      ip = request.remote_ip
      location = Geocoder.search(ip).first
      user_agent = request.user_agent
      @detector = DeviceDetector.new(user_agent)
      if location
        city = location.city || "Ville inconnue"
        country = location.country || "Pays inconnu"
        if @detector.device_name
          @device = utilisateur.devices.build(systeme: "#{@detector.os_name} #{@detector.os_full_version}", marque: @detector.device_name, pays: "#{city}, #{country}", ip: ip)
        else
          @device = utilisateur.devices.build(systeme: "#{@detector.os_name} #{@detector.os_full_version}", marque: @detector.device_type, pays: "#{city}, #{country}", ip: ip)
        end
        @device.save
      end
      redirect_to root_path, notice: "Bienvenue, #{utilisateur.nom}!"
    else
      flash[:alert] = "Email ou mot de passe incorrect"
      redirect_to login_path
    end
  end

  def destroy
    session[:utilisateur_id] = nil  # Supprimer la session pour déconnecter l'utilisateur
    redirect_to login_path, notice: "Vous êtes déconnecté."
  end
end
