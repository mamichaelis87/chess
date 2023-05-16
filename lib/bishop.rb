require_relative 'piece.rb'

class Bishop < Piece
  attr_accessor :potential_moves, :symbol, :name

  def initialize(color, location)
    super
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2657"
    else
      @symbol = "\u265d"
    end
    @name = "#{@color} Bishop"
  end

  def update_moves(current_board = @blank_board)
    #updates potential moves based on location and updates 
    new_moves = []
    square = [@location[0] + 1, @location[1] + 1]
    while @blank_board.include?(square) #adds up right squares
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
      square[1] += 1
    end
    square = [@location[0] + 1, @location[1] - 1]
    while @blank_board.include?(square) #adds down right squares
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
      square[1] -= 1
    end
    square = [@location[0] - 1, @location[1] + 1]
    while @blank_board.include?(square) #adds up left squares
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
      square[1] += 1
    end
    square = [@location[0] - 1, @location[1] - 1]
    while @blank_board.include?(square) #adds down left squares
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
      square[1] -= 1
    end
    @potential_moves = new_moves
  end

end

# left_white_bishop = Bishop.new("white", [2,0])
# p left_white_bishop.potential_moves

