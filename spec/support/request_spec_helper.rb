module RequestSpecHelper
    def json
      JSON.parse(response.body)
    end

    def set_board (s_class_no)
      @board = Board.find_by(class_no: s_class_no)
      @board.id
    end
  end