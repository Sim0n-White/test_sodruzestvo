class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  def index
    @courses = Course.all
    render json: @courses
  end

  def show
    render json: @course
  end

  def create
    result = CourseEvents::Create.new(course_params).call
    return render json: result, status: :created if result.is_a?(Course)

    render json: result[:errors], status: :unprocessable_entity
  end

  def update
    result = CourseEvents::Update.new(@author, author_params).call
    return render json: result, status: :ok if result.is_a?(Course)

    render json: result[:errors], status: :unprocessable_entity
  end

  def destroy
    @course.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :author_id, competency_ids: [])
  end
end
