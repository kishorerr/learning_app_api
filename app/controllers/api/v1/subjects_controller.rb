class Api::V1::SubjectsController < Api::ApiController
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_subject, only: %i[ update destroy ]


  def index
    @subjects = Subject.where(:s_class_id => params[:s_class_id], :board_id => params[:board_id])

    render json: @subjects
  end



  def create
    @subject = Subject.new(:s_name => params[:s_name], :s_class_id => params[:s_class_id], :board_id =>  params[:board_id] )

    if @subject.save
      render json: @subject, status: :created
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  def update
    if @subject.update(subject_params)
      render json: @subject, status: :no_content
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @subject.destroy
  end

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.permit(:s_name, :s_logo, :s_class_id, :board_id)
    end
end
