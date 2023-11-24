class CheckInsController < ApplicationController
    before_action :authenticate_owner!, only: [:index, :create]


  def index
    @rooms = current_owner.inn.rooms
  end

  def create
    @reserva = Reservation.find(params[:reservation_id])
    @check_in = CheckIn.new(reservation_id: @reserva.id, entry: Time.now)
    if Time.now > @reserva.start_date
      @check_in.save
      @reserva.active!
      redirect_to reservations_path, notice: 'Check-in feito com sucesso. Reserva em andamento!'
    else
      redirect_to reservations_path, notice: 'O Check-in só pode ser feito no dia ou depois da data de entrada
                                              da reserva'
    end

  end

  private
  def check_in_params
    params.require(:check_in).permit(:reservation_id, :entry)
  end
end
