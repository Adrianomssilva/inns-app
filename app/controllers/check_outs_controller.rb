class CheckOutsController < ApplicationController

  before_action :fetch_reserva, only: [:new, :create]

  def new
    @check_out = CheckOut.new
    @saida = Time.now
    @total = CheckOut.total_calculate(@reserva, @saida)
  end

  def create
    @check_out = CheckOut.new(check_out_params)
    @check_out.reservation = @reserva
    if @check_out.save
      @reserva.finish!
      redirect_to reservations_path, notice: "Reserva encerrada com sucesso!"
    else
      flash.now[:notice] = 'Não foi possível encerra a reserva'
      render 'new'
    end
  end


  private

  def check_out_params
    params.require(:check_out).permit(:reservation_id, :exit, :total)
  end

  def fetch_reserva
    @reserva = Reservation.find(params[:reservation_id])
  end

end
