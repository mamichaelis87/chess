
class King
  attr_accessor :potential_moves, :symbol, :first_move

  def initialize(color, location)
    super
    @potential_moves = update_moves
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

end

white_king = King.new("white", [4,0])
p white_king.potential_moves