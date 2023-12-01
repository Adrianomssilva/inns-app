class ReservationsController < ApplicationController

  before_action :authenticate_user!, only: [:confirmation]
  before_action :authenticate_owner!, only: [:index, :owner_cancel]
  before_action :fetch_room, only: [:new, :create, :confirmation, :reservation_create]
  before_action :fetch_reservation, only: [:show, :cancel, :owner_cancel]


  def index
    @rooms = current_owner.inn.rooms
  end

  def new
    @reservation = @room.reservations.build
  end

  def show; end

  def create
    @reservation = @room.reservations.build(reservation_params)
    if @reservation.valid?
      session[:temp_reserve] = reservation_params.merge("total_value" => @reservation.total_value)
      redirect_to confirmation_new_room_reservation_path
    else
      flash.now[:notice] = 'Verifique os erros.'
      render 'new'
    end
  end

  def confirmation
    @reservation = @room.reservations.build(session[:temp_reserve])
  end

  def reservation_create
    @reservation = @room.reservations.build(session[:temp_reserve])
    @reservation.user = current_user
    if @reservation.save
      redirect_to my_reservations_path, notice: 'Sua reserva foi confirmada'
      session.delete(:temp_reserve)
    else
      flash.now[:notice] = 'Verifique os erros'
      render 'new'
    end
  end

  def my_reservations
    @reservations = current_user.reservations

  end

  def cancel
    if Time.now <= @reservation.start_date - 7.days
      @reservation.canceled!
      redirect_to my_reservations_path, notice: 'Sua reserva foi cancelada'
    else
      redirect_to my_reservations_path, notice: 'Você não pode mais cancelar a reserva, entre em contato
                                                  com a pousada.'
    end
  end

  def owner_cancel
    if Time.now >= @reservation.start_date + 3.days
      @reservation.canceled!
      redirect_to reservations_path, notice: 'A reserva foi cancelada'
    else
      redirect_to reservations_path, notice: 'Você ainda não pode cancelar essa reserva'
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :guest_number, :status, :total_value)
  end

  def fetch_room
    @room = Room.find(params[:room_id])
  end

  def fetch_reservation
    @reservation = Reservation.find(params[:id])
  end

end
