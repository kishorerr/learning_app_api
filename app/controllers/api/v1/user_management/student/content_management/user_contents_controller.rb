class Api::V1::UserManagement::Student::ContentManagement::UserContentsController < Api::ApiController
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!
  before_action :set_student_enroll
  before_action :create_user_content
  before_action :set_user_content, only: %i[ show update destroy ]

  def upvote
    @user_content = @student_enroll.user_contents.find_by(content_id: params[:content_id])
    @user_content.update_column(:upvote, "true")
    @user_content.update_column(:downvote, "false")
    render json:@user_content
  end

  def downvote
    @user_content = @student_enroll.user_contents.find_by(content_id: params[:content_id])
    @user_content.update_column(:downvote, "true")
    @user_content.update_column(:upvote, "false")
    render json:@user_content
  end

  def notes
    @user_content = @student_enroll.user_contents.find_by(content_id: params[:content_id])
    @user_content.update_column(:notes, params[:notes])
    render json:@user_content
  end

  def content_details
    @user_content = @student_enroll.user_contents.find_by(content_id: params[:content_id])
    render json:@user_content
  end

  def status
    @user_content = @student_enroll.user_contents.find_by(content_id: params[:content_id])
    @user_content.update_column(:status, params[:status])
    render json:@user_content
  end

  private
    
    def set_student_enroll
      @current_user = current_user
      @student_enroll = StudentEnroll.find_by(id: @current_user.id)
    end

    def create_user_content
      unless @student_enroll.user_contents.find_by(content_id: params[:content_id]).present?
        @student_enroll.user_contents.create!(upvote: false, downvote: false, notes: "",status: 'started', content_id: params[:content_id],student_enroll_id: @student_enroll.student_id)
      end
    end
end
