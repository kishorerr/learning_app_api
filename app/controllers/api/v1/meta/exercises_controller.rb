class Api::V1::Meta::ExercisesController < Api::ApiController

  respond_to :json
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_chapter
  before_action :set_exercise, only: %i[ show ]

  def index
    render json: @chapter.exercises
  end

  def show
    render json: @exercise
  end

  def create
    @chapter.exercises.create!(exercise_params)
    render json: @exercise, status: :created
  end

  private


  def set_chapter
    @chapter = Chapter.find(params[:chapter_id])
  end

  def set_exercise
    @exercise = @chapter.exercises.find_by!(id: params[:id])
  end

  def exercise_params
    params.permit(:title,:duration,:qn_no,:instructions,:chapter_id)
  end
end
