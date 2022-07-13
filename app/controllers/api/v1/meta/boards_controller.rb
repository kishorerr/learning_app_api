class Api::V1::Meta::BoardsController < Api::ApiController
  respond_to :json
  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!
  before_action :set_board, only: %i[ update destroy ]
 
  def index
    @boards = Board.all
    render json: @boards, serializer: BoardSerializer
  end

  def show
    @board= Board.find(params[:id])
    render json: @board
  end
  
  def create
    @board = Board.new(board_params)

    if @board.save
      render json: @board, status: :created
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end


  def update
    if @board.update(board_params)
      render json: @board, status: :created
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @board.destroy
  end

  private

    def set_board
      @board = Board.find(params[:id])
    end

    
    def board_params
      params.permit(:b_name, :b_desc)
    end
    
end
