class CheckOutsController < ApplicationController

  def new
    @reserva = Reservation.find(params[:reservation_id])
    @check_out = CheckOut.new
    @saida = Time.now
    @total = CheckOut.total_calculate(@reserva, @saida)
  end

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @check_out = CheckOut.new(check_out_params)
    @check_out.reservation = @reservation
    if @check_out.save
      @reservation.finish!
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

end
