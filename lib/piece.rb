
class Piece 
  attr_accessor :color, :location, :blank_board

  def initialize(color, location) 
    @color = color
    @location = location
    @blank_board = create_blank_board
    
  end

  def occupied(current_board, square)
    #checks if there is a piece obstructing the path
    if current_board == @blank_board
      return nil
    end
    unless @blank_board.include?(square)
      return nil
    end
    piece = current_board[square[0]][square[1]]
    if piece
      if piece.color == "black"
        return "black"
      elsif piece.color == "white"
        return "white"
      end
    end
    nil
  end

  def create_blank_board
    array = []
    width = 0
    while width <= 7
      height = 0
      while height <= 7
        array << [width, height]
        height += 1
      end
      width += 1 
    end
    return array
  end
end