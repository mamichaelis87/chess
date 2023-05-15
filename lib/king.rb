
class King
  attr_accessor :potential_moves, :symbol, :first_move

  def initialize(color, location)
    super
    @potential_moves = update_moves
    @first_move = true
  end

  def update_moves(current_board = @blank_board)
    #updates potential moves based on location and updates
    new_moves = []

   
    new_moves << [@location[0] - 1, @location[1] - 1] if @blank_board.include?([@location[0] - 1, @location[1] - 1])
    new_moves << [@location[0] - 1, @location[1]] if @blank_board.include?([@location[0] - 1, @location[1]])
    new_moves << [@location[0] - 1, @location[1] + 1] if @blank_board.include?([@location[0] - 1, @location[1]])
    new_moves << [@location[0], @location[1] + 1] if @blank_board.include?([@location[0], @location[1] + 1])
    new_moves << [@location[0] + 1, @location[1] + 1] if @blank_board.include?([@location[0] + 1, @location[1] + 1])
    new_moves << [@location[0] + 1, @location[1]] if @blank_board.include?([@location[0] + 1, @location[1]])
    new_moves << [@location[0] + 1, @location[1] - 1] if @blank_board.include?([@location[0] + 1, @location[1] - 1])
    new_moves << [@location[0], @location[1] - 1] if @blank_board.include?([@location[0], @location[1] - 1])
    

    new_moves.each do |square|
      if occupied(current_board, square) == @color
        #if same color, remove from new_moves
        new_moves.delete(square)
      end
    end
    @potential_moves = new_moves
  end

end

white_king = King.new("white", [4,0])
p white_king.potential_moves