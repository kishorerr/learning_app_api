class Api::V1::Meta::ContentsController < Api::ApiController
  respond_to :json
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_chapter
  before_action :set_content, only: %i[ show update destroy ]
  

  def index
    render json: @chapter.contents
  end

  def show
    render json: @content
  end

  def create
    @chapter.contents.create!(content_params)
    render json: @content, status: :created
  end

  def update
    if @content.update(content_params)
      render json: @content, status: :created
    else
      render json: @content.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @content.destroy
  end

  private
    def set_chapter
      @chapter = Chapter.find(params[:chapter_id])
    end
    
    def set_content
      @content = @chapter.contents.find_by!(id: params[:id])
    end

    def content_params
      params.permit(:content, :link)
    end
end
