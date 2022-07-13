class Api::V1::Meta::OptionsController < Api::ApiController

  respond_to :json
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_question
  before_action :set_option, only: %i[ update ]

  def index
    render json: @question.options
  end

  def create
    @option_new = @question.options.create!(option_params)
    render json: @option_new, status: :created
  end

  def update
    @option.update(option_params)
    render json: @question, status: :created
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_option
    @option = @question.options.find_by(id: params[:id])
  end

  def option_params
    params.permit(:option_name,:option,:opt_status,:question_id)
  end
end
