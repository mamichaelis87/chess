
class Queen
  attr_accessor :color, :location, :potential_moves, :symbol

  def initialize(color, location)
    @color = color
    @location = location
    @blank_board = create_blank_board
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2655"
    else
      @symbol = "\u265b"
    end
  end

  def update_moves
    #updates potential moves based on location and updates 
    #for diagonals (from bishop)
    new_moves = []
    square = [@location[0] + 1, @location[1] + 1]
    while @blank_board.include?(square) #adds up right squares
      if occupied
        #if same color, break, if not then add square and then break
      end
      new_moves << [square[0], square[1]] 
      square[0] += 1 
      square[1] += 1
    end
    square = [@location[0] + 1, @location[1] - 1]
    while @blank_board.include?(square) #adds down right squares
      if occupied
        #if same color, break, if not then add square and then break
      end
      new_moves << [square[0], square[1]] 
      square[0] += 1 
      square[1] -= 1
    end
    square = [@location[0] - 1, @location[1] + 1]
    while @blank_board.include?(square) #adds up left squares
      if occupied
        #if same color, break, if not then add square and then break
      end
      new_moves << [square[0], square[1]] 
      square[0] -= 1 
      square[1] += 1
    end
    square = [@location[0] - 1, @location[1] - 1]
    while @blank_board.include?(square) #adds down left squares
      if occupied
        #if same color, break, if not then add square and then break
      end
      new_moves << [square[0], square[1]] 
      square[0] -= 1 
      square[1] -= 1
    end

    #for horiz/vert (From rook)
    [0,1,2,3,4,5,6,7].each do |row|
      if occupied
        #if matches color then #if same color, break, if not then add square and then break
        #if enemy color, add to the moves and then #if same color, break, if not then add square and then break
      else
        new_moves << [@location[0], row]
      end
    end
    [0,1,2,3,4,5,6,7].each do |column|
      if occupied
        #if matches color then #if same color, break, if not then add square and then break
        #if enemy color, add to the moves and then #if same color, break, if not then add square and then break
      else
        new_moves << [column, @location[1]]
      end
    end
    new_moves.delete(@location)

    @potential_moves = new_moves
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

white_queen = Queen.new("white", [3,0])
p white_queen.potential_moves