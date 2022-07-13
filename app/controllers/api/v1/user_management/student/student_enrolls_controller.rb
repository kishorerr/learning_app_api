class Api::V1::UserManagement::Student::StudentEnrollsController < Api::ApiController
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!
  before_action :set_student_enroll, only: %i[ update index ]


  def index
  render json: @student_enroll, include: ['board', 's_class']
  end

  def update
    if board_params.present?
      @student_enroll.update_column(:board_id, params[:board_id])
      render json:@student_enroll, status: :created
    end

    if class_params.present?
      @student_enroll.update_column(:s_class_id, params[:class_id])
      render json:@student_enroll, status: :created
    end
  end

  private
    def set_student_enroll
      @current_user = current_user
      @student_enroll = StudentEnroll.find_by(id: @current_user.id)
    end

    def board_params
      params.permit(:board_id)
    end

    def class_params 
      params.permit(:class_id)
    end

end
