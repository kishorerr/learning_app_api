class Api::V1::Meta::QuestionsController < Api::ApiController

  respond_to :json
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_exercise
  before_action :set_question, only: %i[ update ]

  def index
    render json: @exercise.questions
  end

  def create
    @question = @exercise.questions.create!(question_params)
    render json: @question, status: :created
  end

  def update
    @question.update(question_params)
    render json: @question, status: :created
  end

  private
  def set_exercise
    @exercise = Exercise.find(params[:exercise_id])
  end

  def set_question
    @question = @exercise.questions.find_by(id: params[:id])
  end

  def question_params
    params.permit(:qn_no,:question,:duration,:solution,:exercise_id)
  end
end
