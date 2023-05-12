
class Pawn 
  attr_accessor :color, :location, :potential_moves, :symbol, :first_move
  
  def initialize(color, location) 
    @color = color
    @location = location
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2659"
    else
      @symbol = "\u265f"
    end
    @first_move = true
  end

  def update_moves
    #updates potential moves based on location and updates
    #moves up one if white, down one if black
    #moves up two if first move
  end
end