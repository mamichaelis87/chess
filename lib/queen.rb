
class Queen
  attr_accessor :color, :location, :potential_moves, :symbol
  
  def initialize(color, location)
    @color = color
    @location = location
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2655"
    else
      @symbol = "\u265b"
    end
  end

  def update_moves
    #updates potential moves based on location and updates 
  end

end