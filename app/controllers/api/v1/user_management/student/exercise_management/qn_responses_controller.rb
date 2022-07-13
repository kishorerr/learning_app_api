class Api::V1::UserManagement::Student::ExerciseManagement::QnResponsesController < Api::ApiController

  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!
  before_action :set_student_enroll
  before_action :set_exercise
  before_action :set_attempt
  before_action :set_question
  before_action :set_option
  before_action :set_qn_response

  
  def create
    if @qn_response.present?
      @qn_response.update(qn_response_params)
      if @option.opt_status == "correct"
        @qn_response.update_column(:score, 1)
      else
        @qn_response.update_column(:score,0)
      end
      render json: @qn_response, status: :created
    else
      @qn_response_new = @attempt.qn_responses.create!(qn_response_params)
      if @option.opt_status == "correct"
        @qn_response.update_column(:score, 1)
      else
        @qn_response.update_column(:score,0)
      end
      render json: @qn_response_new, status: :created
    end
  end


  private

    def set_attempt
      @attempt_inst = Attempt.where(:student_enroll_id => @student_enroll.id, :exercise_id => @exercise.id).last
      @attempt = Attempt.find_by(id: @attempt_inst.id)
    end

    def set_exercise
      @exercise = Exercise.find_by(id: params[:exercise_id])
    end

    def set_question
      @question = Question.find_by(id: params[:question_id])
    end

    def set_student_enroll
      @current_user = current_user
      @student_enroll = StudentEnroll.find_by(id: @current_user.id)
    end

    def set_qn_response
      @qn_response_inst = QnResponse.where(:attempt_id => @attempt.id, :question_id => @question.id).first
      @qn_response = QnResponse.find(@qn_response_inst.id)
    end

    def set_option
      @option_inst =Option.where(:question_id => params[:question_id],:option_name => params[:selected_option]).first
      @option = Option.find(@option_inst.id)
    end

    def qn_response_params
      params.permit(:selected_option, :marked_for_review, :question_id)
    end
end
