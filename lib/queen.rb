require_relative 'piece.rb'

class Queen < Piece
  attr_accessor :potential_moves, :symbol, :name

  def initialize(color, location)
    super
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u265b"
    else
      @symbol = "\u2655"
    end
    @name = "#{@color} Queen"
  end

  def update_moves(current_board = @blank_board)
    #updates potential moves based on location and updates 
    #for diagonals (from bishop)
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

    #for horiz/vert (From rook)
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

# white_queen = Queen.new("white", [3,0])
# p white_queen.potential_moves