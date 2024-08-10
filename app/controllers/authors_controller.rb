class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :update, :destroy]

  def index
    @authors = Author.all
    render json: @authors
  end

  def show
    render json: @author
  end

  def create
    result = AuthorEvents::Create.new(author_params).call
    return render json: result, status: :created if result.is_a?(Author)

    render json: result[:errors], status: :unprocessable_entity
  end

  def update
    result = AuthorEvents::Update.new(@author, author_params).call
    return render json: result, status: :ok if result.is_a?(Author)

    render json: result[:errors], status: :unprocessable_entity
  end

  def destroy
    result = AuthorEvents::Destroy.new(@author).call
    if result[:success]
      head :no_content
    else
      render json: result[:errors], status: :unprocessable_entity
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
