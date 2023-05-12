
class Rook 
  attr_accessor :color, :location, :potential_moves, :symbol, :first_move

  def initialize(color, location)
    @color = color
    @location = location 
    @blank_board = create_blank_board
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2656"
    else
      @symbol = "\u265c"
    end
    @first_move = true
  end

  def update_moves
    #updates potential moves based on location and updates 
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