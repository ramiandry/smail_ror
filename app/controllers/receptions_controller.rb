class ReceptionsController < ApplicationController
  before_action :set_reception, only: [ :show, :destroy ]
  def index
    @receptions = Reception.all
  end

  def show
  end

  def create
    @reception = Reception.new(reception_params)

    if @reception.save
      if params[:pieces_jointes]
        params[:pieces_jointes].each do |file|
          @reception.pieces_jointes.attach(file)
        end
      end

      redirect_to @reception, notice: "Réception créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @reception.destroy
    redirect_to receptions_path, notice: "Réception supprimée avec succès."
  end

  private

  def set_reception
    @reception = Reception.find(params[:id])
  end

  def reception_params
    params.require(:reception).permit(:nom, :email, :date_reception, pieces_jointes: [])
  end
end
