
class King
  attr_accessor :color, :location, :potential_moves, :symbol, :first_move

  def initialize(color, location)
    @color = color
    @location = location
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
  end

end