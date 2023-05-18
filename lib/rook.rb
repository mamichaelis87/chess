require_relative 'piece.rb'

class Rook < Piece
  attr_accessor :potential_moves, :first_move, :symbol, :name
  def initialize(color, location)
    super
    @first_move = true
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u265c"
    else
      @symbol = "\u2656"
    end
    @name = "#{@color} Rook"
  end

  def update_moves(current_board = @blank_board)
    #updates potential moves based on location and updates 
    new_moves = []

    square = [@location[0], @location[1] + 1]
    while @blank_board.include?(square) #adds up squares
      if occupied(current_board, square) == @color
        #if same color, break, if not then add square and then break
        break
      elsif occupied(current_board, square)
        new_moves << [square[0], square[1]]
        break
      else
        new_moves << [square[0], square[1]] 
      end
      square[1] += 1
    end

    square = [@location[0], @location[1] - 1]
    while @blank_board.include?(square) #adds down squares
      if occupied(current_board, square) == @color
        #if same color, break, if not then add square and then break
        break
      elsif occupied(current_board, square)
        new_moves << [square[0], square[1]]
        break
      else
        new_moves << [square[0], square[1]] 
      end
      square[1] -= 1
    end
  

    square = [@location[0] - 1, @location[1]]
    while @blank_board.include?(square) #adds left squares
      if occupied(current_board, square) == @color
        #if same color, break, if not then add square and then break
        break
      elsif occupied(current_board, square)
        new_moves << [square[0], square[1]]
        break
      else
        new_moves << [square[0], square[1]] 
      end
      square[0] -= 1 
    end

    square = [@location[0] + 1, @location[1]]
    while @blank_board.include?(square) #adds right squares
      if occupied(current_board, square) == @color
        #if same color, break, if not then add square and then break
        break
      elsif occupied(current_board, square)
        new_moves << [square[0], square[1]]
        break
      else
        new_moves << [square[0], square[1]] 
      end
      square[0] += 1 
    end
    @potential_moves = new_moves
  end
end

# black_left_rook = Rook.new("black", [0,7])
# p black_left_rook.potential_moves