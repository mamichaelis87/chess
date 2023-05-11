
class Bishop
  
  def initialize(color, location)
    @color = color
    @location = location
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2657"
    else
      @symbol = "\u265d"
    end
  end

  def update_moves
    #updates potential moves based on location and updates 
  end

end