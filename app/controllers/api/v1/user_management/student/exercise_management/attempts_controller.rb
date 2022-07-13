class Api::V1::UserManagement::Student::ExerciseManagement::AttemptsController < Api::ApiController

  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!
  before_action :set_student_enroll
  before_action :set_exercise
  before_action :set_attempt, only: %i[ create show update ]

  
  def index
    
    @attempts = Attempt.where(:student_enroll_id => @student_enroll.id, :exercise_id => @exercise.id)
    render json: @attempts
  end

  
  def show
    render json: @attempt
  end

  def update
    @attempt.update_column(:finished_at, DateTime.now)
    @attempt.update_column(:score,QnResponse.where(:attempt_id => @attempt.id).sum(:score) )
    attempt_no = @exercise.attempts_no.to_i + 1
    @exercise.update_column(:attempts_no, attempt_no)
    highscore = Attempt.where(:student_enroll_id => @student_enroll.id, :exercise_id => @exercise.id).maximum(:score)
    @exercise.update_column(:high_score, highscore)
    render json: @attempt 
  end


  def create
    if @attempt.present?
      check_val=@attempt.finished_at
      if check_val.nil?
        render json: {message:"Previous attempt has not been finished", attempt_id: @attempt.id}, status: :unprocessable_entity
      else
        @attempt_new = @student_enroll.attempts.create!(attempted_at: DateTime.now, exercise_id: @exercise.id )
        render json: @attempt_new, status: :created
      end
    else
      @attempt_new = @student_enroll.attempts.create!(attempted_at: DateTime.now, exercise_id: @exercise.id )
      render json: @attempt_new, status: :created
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

    def set_student_enroll
      @current_user = current_user
      @student_enroll = StudentEnroll.find_by(id: @current_user.id)
    end
    
    def attempt_params
      params.permit(:score, :attempted_at, :exercise_id, :student_enroll_id)
    end
end
