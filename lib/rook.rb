require_relative 'piece.rb'

class Rook < Piece
  attr_accessor :potential_moves, :first_move, :symbol

  def initialize(color, location)
    super
    @first_move = true
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2656"
    else
      @symbol = "\u265c"
    end
  end

  def update_moves(current_board = @blank_board)
    #updates potential moves based on location and updates 
    new_moves = []
    #cycle through column and add squares
      #if it is same color, stop
      #if it is enemy color, add square and then stop
      [0,1,2,3,4,5,6,7].each do |row|
        if occupied(current_board, [@location[0], row]) == @color
          break
        elsif occupied(current_board, [@location[0], row])
          new_moves << [@location[0], row]
          break
        else
          new_moves << [@location[0], row]
        end
      end
      [0,1,2,3,4,5,6,7].each do |column|
        if occupied(current_board, [column, @location[1]]) == @color
          break
        elsif occupied(current_board, [column, @location[1]])
          new_moves << [column, @location[1]]
          break
        else
          new_moves << [column, @location[1]]
        end
      end
      new_moves.delete(@location)
      @potential_moves = new_moves
  end

end

# black_left_rook = Rook.new("black", [0,7])
# p black_left_rook.potential_moves