
class Bishop
  attr_accessor :color, :location, :potential_moves, :symbol, :blank_board

  def initialize(color, location)
    @color = color
    @location = location
    @blank_board = create_blank_board
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2657"
    else
      @symbol = "\u265d"
    end
  end

  def update_moves
    #updates potential moves based on location and updates 
    new_moves = []
    square = [@location[0] + 1, @location[1] + 1]
    while @blank_board.include?(square) #adds up right squares
      if occupied
        #if same color, break, if enemy color, add then break
      end
      new_moves << [square[0], square[1]] 
      square[0] += 1 
      square[1] += 1
    end
    square = [@location[0] + 1, @location[1] - 1]
    while @blank_board.include?(square) #adds down right squares
      if occupied
        #if same color, break, if enemy color, add then break
      end
      new_moves << [square[0], square[1]] 
      square[0] += 1 
      square[1] -= 1
    end
    square = [@location[0] - 1, @location[1] + 1]
    while @blank_board.include?(square) #adds up left squares
      if occupied
        #if same color, break, if enemy color, add then break
      end
      new_moves << [square[0], square[1]] 
      square[0] -= 1 
      square[1] += 1
    end
    square = [@location[0] - 1, @location[1] - 1]
    while @blank_board.include?(square) #adds down left squares
      if occupied
        #if same color, break, if enemy color, add then break
      end
      new_moves << [square[0], square[1]] 
      square[0] -= 1 
      square[1] -= 1
    end
    @potential_moves = new_moves
  end

  private 

  def occupied#(current_board) #just a holder method for now
    #checks if there is a piece obstructing the path
    false
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

left_white_bishop = Bishop.new("white", [2,0])
p left_white_bishop.potential_moves

