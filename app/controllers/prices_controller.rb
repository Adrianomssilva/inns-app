class PricesController < ApplicationController

  before_action :authenticate_owner!

  def new
    @room = Room.find(params[:room_id])
    @price = Price.new
  end

  def create
    @room = Room.find(params[:room_id])
    @price = Price.new(price_params)
    @price.room = @room
    if @price.save
    redirect_to my_rooms_path, notice: 'Preço cadastrado com sucesso'
    else
    flash.now[:notice] = "Não foi possível carregar o preço"
    render 'new'
    end
  end


  private

  def price_params
    params.require(:price).permit(:value, :date_start, :date_end, :room_id)
  end
end
