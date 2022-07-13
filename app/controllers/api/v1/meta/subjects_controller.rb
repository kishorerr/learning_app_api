class Api::V1::Meta::SubjectsController < Api::ApiController
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_s_class
  before_action :set_subject, only: %i[ update destroy show ]


  def index
    @subjects = @s_class.subjects
    render json: @subjects
  end

  def show
    render json: @subject
  end

  def create
    @subject = @s_class.subjects.create!(subject_params)

    if @subject.save
      render json: @subject, status: :created
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  def update
    if @subject.update(subject_params)
      render json: @subject, status: :created
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @subject.destroy
  end

  private
    def set_s_class
      @s_class = SClass.find_by(id: params[:s_class_id])
    end

    def set_subject
      @subject = @s_class.subjects.find_by!(id: params[:id])
    end

    def subject_params
      params.permit(:s_name, :s_logo)
    end
end
