class Api::V1::SClassesController < Api::ApiController
  respond_to :json
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!, only: %i[create index destroy update]
  before_action :set_s_class, only: %i[ show update destroy ]


  def index
    @s_classes = SClass.all

    render json: @s_classes
  end


  def create
    @s_class = SClass.new(s_class_params)

    if @s_class.save
      render json: @s_class, status: :created
    else
      render json: @s_class.errors, status: :unprocessable_entity
    end
  end


  def update
    if @s_class.update(s_class_params)
      render json: @s_class, status: :no_content
    else
      render json: @s_class.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @s_class.destroy
  end

  private
  
    def set_s_class
      @s_class = SClass.find(params[:id])
    end


    def s_class_params
      params.permit(:class_no)
    end
end
