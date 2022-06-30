class Api::V1::UserManagement::Student::StudentEnrollsController < Api::ApiController
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!
  before_action :set_student_enroll, only: %i[ update ]

  def update
    if board_params.present?
      @board = Board.find_by(b_name: params[:board])
      @student_enroll.update_column(:board_id, @board.id)
      render json: {status:"board has been updated", details:{student_id: @student_enroll.student_id, board_id: @student_enroll.board_id }}, status: :no_content
    end

    if class_params.present?
      @class_no = SClass.find_by(class_no: params[:class])
      @student_enroll.update_column(:s_class_id, @class_no.id)
      render json: {status:"class has been updated", details:{student_id: @student_enroll.student_id, class_id: @student_enroll.s_class_id }}, status: :no_content
    end
  end

  private
    def set_student_enroll
      @student_enroll = current_user.student_enroll
    end

    def board_params
      params.permit(:board)
    end

    def class_params 
      params.permit(:class)
    end

end
