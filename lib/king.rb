
class King
  attr_accessor :color, :location, :potential_moves, :symbol, :first_move, :blank_board

  def initialize(color, location)
    @color = color
    @location = location
    @blank_board = create_blank_board
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2654"
    else
      @symbol = "\u265a"
    end
    @first_move = true
  end

  def update_moves
    #updates potential moves based on location and updates
    new_moves = []

    unless occupied
      new_moves << [@location[0] - 1, @location[1] - 1] if @blank_board.include?([@location[0] - 1, @location[1] - 1])
    end
    unless occupied
      new_moves << [@location[0] - 1, @location[1]] if @blank_board.include?([@location[0] - 1, @location[1]])
    end
    unless occupied
      new_moves << [@location[0] - 1, @location[1] + 1] if @blank_board.include?([@location[0] - 1, @location[1]])
    end
    unless occupied
      new_moves << [@location[0], @location[1] + 1] if @blank_board.include?([@location[0], @location[1] + 1])
    end
    unless occupied
      new_moves << [@location[0] + 1, @location[1] + 1] if @blank_board.include?([@location[0] + 1, @location[1] + 1])
    end
    unless occupied
      new_moves << [@location[0] + 1, @location[1]] if @blank_board.include?([@location[0] + 1, @location[1]])
    end
    unless occupied
      new_moves << [@location[0] + 1, @location[1] - 1] if @blank_board.include?([@location[0] + 1, @location[1] - 1])
    end
    unless occupied
      new_moves << [@location[0], @location[1] - 1] if @blank_board.include?([@location[0], @location[1] - 1])
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

white_king = King.new("white", [4,0])
p white_king.potential_moves