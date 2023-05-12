
class Rook 
  attr_accessor :color, :location, :potential_moves, :symbol, :first_move

  def initialize(color, location)
    @color = color
    @location = location 
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
end