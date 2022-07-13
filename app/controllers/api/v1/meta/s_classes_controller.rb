class Api::V1::Meta::SClassesController < Api::ApiController
  respond_to :json
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_board
  before_action :set_s_class, only: %i[ show update destroy ]


  def index
    @s_classes = @board.s_classes

    render json: @s_classes
  end

  def show
  render json: @s_class
  end

  def create
    @s_class = @board.s_classes.create!(s_class_params)

    if @s_class.save
      render json: @s_class, status: :created
    else
      render json: @s_class.errors, status: :unprocessable_entity
    end
  end


  def update
    if @s_class.update(s_class_params)
      render json: @s_class, status: :created
    else
      render json: @s_class.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @s_class.destroy
  end

  private

    def set_board
      @board = Board.find_by(id: params[:board_id])
    end
    def set_s_class
      @s_class = @board.s_classes.find_by!(id: params[:id]) 
    end

    def s_class_params
      params.permit(:class_no)
    end
end
