class AnswersController < ApplicationController

  before_action :authenticate_owner!, only: [:new]

  def new
    @avaliation = Avaliation.find(params[:avaliation_id])
    @answer = Answer.new
  end

  def create
    @avaliation = Avaliation.find(params[:avaliation_id])
    @answer = Answer.new(answer_params)
    @answer.avaliation = @avaliation

    if @answer.save
      redirect_to avaliations_path, notice: 'Resposta enviada com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível enviar a resposta'
      render 'new'
    end
  end


  private

  def answer_params
    params.require(:answer).permit(:text, :avaliation_id)
  end

end
