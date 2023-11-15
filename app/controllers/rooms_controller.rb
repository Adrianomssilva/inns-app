class RoomsController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.inn = current_owner.inn
    if @room.save
      redirect_to my_inn_path, notice: 'Quarto criado com sucesso'
    else
      falsh:now[:notice] = 'Não foi possível criar o quarto'
      render 'new'
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit

    @room = Room.find(params[:id])
    if current_owner != @room.inn.owner
      redirect_to my_rooms_path, notice: 'Você não tem acesso a esse quarto'
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to my_rooms_path, notice: 'Quarto editado com sucesso'
    else
      flash.now[:notice] = 'Quarto não foi editado'
      render 'edit'
    end
  end

  def unavailable
    room = Room.find(params[:id])
    room.unavailable!
    redirect_to my_rooms_path, notice: "#{room.name} indisponível"
  end

  def available
    room = Room.find(params[:id])
    room.available!
    redirect_to my_rooms_path, notice: "#{room.name} disponível"
  end

  def my_rooms
    @rooms = current_owner.inn.rooms
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :dimension, :capacity, :default_price, :bathroom, :balcony, :air_conditioning, :tv, :wardrobe, :safe, :pcd, :inn_id, :status)

  end
end
