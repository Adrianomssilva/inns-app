class InnsController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :create, :my_inn, :edit, :update]
  def new
    @inn = Inn.new
  end

  def create
    @inn = Inn.new(inn_params)
    @inn.owner = current_owner
    if @inn.save
      redirect_to my_inn_path, notice: 'Pousada cadastrada com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível cadastrar a pousada'
      render 'new'
    end
  end

  def show
    @inn = Inn.find(params[:id])
    @rooms = @inn.rooms.available
    @avaliations = @inn.avaliations
    if @avaliations.present?
      @nota = Inn.rating(@inn)
    else
    @nota = '--'
    end
  end

  def avaliations
    @inn = Inn.find(params[:id])
    @avaliations = @inn.avaliations
    if @avaliations.present?
      @nota = Inn.rating(@inn)
    else
    @nota = '--'
    end
  end

  def edit
    @inn = Inn.find(params[:id])
    if @inn.owner != current_owner
      redirect_to root_path, notice: 'Você não tem acesso a essa Pousada'
    end
  end

  def update
    @inn = Inn.find(params[:id])

    if @inn.update(inn_params)
      redirect_to my_inn_path, notice: 'Pousada editada com sucesso.'

    else
      flash.now[:notice] = 'Não foi possível editar a pousada.'
      render 'edit'
    end

  end

  def search
    @query_city = params["query_city"]
    @query = params["query"]
    if @query_city.present?
    @inns = Inn.published.where("city = ?", "#{@query_city}").order(:brand_name)
    else
    @inns = Inn.published.where("city LIKE ? OR brand_name LIKE ? OR neighborhood LIKE ? ", "%#{@query}%", "%#{@query}%", "%#{@query}%").order(:brand_name)
    end
  end

  def my_inn
    @inn = current_owner.inn
  end

  def publish
    inn = Inn.find(params[:id])
    inn.published!
    redirect_to my_inn_path, notice: 'Sua Pousada foi publicada!'
  end

  def hidden
    inn = Inn.find(params[:id])
    inn.hidden!
    redirect_to my_inn_path, notice: 'Sua Pousada saiu do ar!'
  end

  private

  def inn_params
    params.require(:inn).permit(:brand_name, :corporate_name, :registration_number, :phone, :email, :address, :neighborhood, :state, :city, :cep, :payment_options, :pets, :policies, :description, :check_in, :check_out, :owner_id, :status)
  end

end
