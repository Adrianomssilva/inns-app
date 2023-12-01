class AvaliationsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_owner!, only: [:index]
  before_action :fetch_reserva, only: [:new, :create]
  def index
    @avaliations = current_owner.inn.avaliations

  end

  def new
    @avaliation = Avaliation.new
  end

  def create
    @avaliation = Avaliation.new(avaliation_params)
    @avaliation.user = current_user
    @avaliation.reservation = @reserva
    @avaliation.inn = @reserva.room.inn
    if @avaliation.save
      redirect_to reservation_path(@reserva), notice: 'Avaliação feita com sucesso.'
    else
      flash.now[:notice] =  'Ocorreu algum erro, não foi possível criar a avaliação.'
      render 'new'
    end
  end


  private

  def avaliation_params
    params.require(:avaliation).permit(:rate, :text, :reservation_id, :inn_id, :user_id)
  end

  def fetch_reserva
    @reserva = Reservation.find(params[:reservation_id])
  end

end
