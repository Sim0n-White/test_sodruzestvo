class CompetenciesController < ApplicationController
  before_action :set_competency, only: [:show, :update, :destroy]

  def index
    @competencies = Competency.all
    render json: @competencies
  end

  def show
    render json: @competency
  end

  def create
    result = CompetencyEvents::Create.new(competency_params).call
    return render json: result, status: :created if result.is_a?(Competency)

    render json: result[:errors], status: :unprocessable_entity
  end

  def update
    result = CompetencyEvents::Update.new(@competency, competency_params).call
    return render json: result, status: :ok if result.is_a?(Competency)

    render json: result[:errors], status: :unprocessable_entity
  end

  def destroy
    @competency.destroy
    head :no_content
  end

  private

  def set_competency
    @competency = Competency.find_by(id: params[:id])
    render json: { error: 'Competency not found' }, status: :not_found unless @competency
  end

  def competency_params
    params.require(:competency).permit(:name, :description)
  end
end
