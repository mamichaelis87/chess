require_relative 'piece.rb'

class King < Piece
  attr_accessor :potential_moves, :symbol, :first_move, :name

  def initialize(color, location)
    super
    @first_move = true
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2654"
    else
      @symbol = "\u265a"
    end
    @name = "#{@color} King"
  end

  def update_moves(current_board = @blank_board)
    #updates potential moves based on location and updates
    new_moves = []

   
    new_moves << [@location[0] - 1, @location[1] - 1] if @blank_board.include?([@location[0] - 1, @location[1] - 1])
    new_moves << [@location[0] - 1, @location[1]] if @blank_board.include?([@location[0] - 1, @location[1]])
    new_moves << [@location[0] - 1, @location[1] + 1] if @blank_board.include?([@location[0] - 1, @location[1] + 1])
    new_moves << [@location[0], @location[1] + 1] if @blank_board.include?([@location[0], @location[1] + 1])
    new_moves << [@location[0] + 1, @location[1] + 1] if @blank_board.include?([@location[0] + 1, @location[1] + 1])
    new_moves << [@location[0] + 1, @location[1]] if @blank_board.include?([@location[0] + 1, @location[1]])
    new_moves << [@location[0] + 1, @location[1] - 1] if @blank_board.include?([@location[0] + 1, @location[1] - 1])
    new_moves << [@location[0], @location[1] - 1] if @blank_board.include?([@location[0], @location[1] - 1])
    
    p new_moves
    new_moves.each do |square|
      if occupied(current_board, square) == @color
        #if same color, remove from new_moves
      puts "removing #{square} from #{@name}"
        new_moves.delete(square)
      end
    end
    @potential_moves = new_moves
  end

end

# white_king = King.new("white", [4,0])
# p white_king.potential_moves