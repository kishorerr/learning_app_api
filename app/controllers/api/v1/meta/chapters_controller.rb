class Api::V1::Meta::ChaptersController < Api::ApiController

  respond_to :json
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_subject
  before_action :set_chapter, only: %i[ show update destroy ]
  

  def index
    render json: @subject.chapters
  end

  def show
    render json: @chapter
  end

  def create
    @subject.chapters.create!(chapter_params)
    render json: @chapter, status: :created
  end

  def update
    if @chapter.update(chapter_params)
      render json: @chapter, status: :created
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @chapter.destroy
  end

  private
    def set_subject
      @subject = Subject.find(params[:subject_id])
    end
    
    def set_chapter
      @chapter = @subject.chapters.find_by!(id: params[:id])
    end

    def chapter_params
      params.permit(:c_name, :pdf_no, :video_no)
    end
end
