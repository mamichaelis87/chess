
class Knight
  attr_accessor :color, :location, :potential_moves, :symbol

  def initialize(color, location)
    @color = color
    @location = location
    @blank_board = create_blank_board
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2658"
    else
      @symbol = "\u265e"
    end
  end

  def update_moves
    #updates potential moves based on location and updatesif location[0] + 2 <= 7
    new_moves = []
    new_moves << [location[0] + 2, location[1] + 1] if @blank_board.include?([location[0] + 2, location[1] + 1])
    new_moves << [location[0] + 2, location[1] - 1] if @blank_board.include?([location[0] + 2, location[1] - 1])
    new_moves << [location[0] - 2, location[1] + 1] if @blank_board.include?([location[0] - 2, location[1] + 1])
    new_moves << [location[0] - 2, location[1] - 1] if @blank_board.include?([location[0] - 2, location[1] - 1])
    new_moves << [location[0] - 1, location[1] + 2] if @blank_board.include?([location[0] - 1, location[1] + 2])
    new_moves << [location[0] - 1, location[1] - 2] if @blank_board.include?([location[0] - 1, location[1] - 2])
    new_moves << [location[0] + 1, location[1] + 2] if @blank_board.include?([location[0] + 1, location[1] + 2])
    new_moves << [location[0] + 1, location[1] - 2] if @blank_board.include?([location[0] + 1, location[1] - 2])
     
    new_moves.each do |square|
      if occupied
        #if same color, remove from new_moves
      end
    end
  end

  private 

  def occupied(current_board, square)
    #checks if there is a piece obstructing the path
    if current_board == @blank_board
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

white_left_knight = Knight.new("white", [1,0])
p white_left_knight.potential_moves