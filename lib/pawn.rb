
class Pawn 
  attr_accessor :color, :location, :potential_moves, :symbol, :first_move, :blank_board
  
  def initialize(color, location) 
    @color = color
    @location = location
    @blank_board = create_blank_board
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2659"
    else
      @symbol = "\u265f"
    end
    @first_move = true
    
  end

  def update_moves#(current_board)
    #updates potential moves based on location and updates
    #moves up one if white, down one if black
    #moves up two if first move
    #does not yet account for en passant move
    new_moves = []
    if @color == "white"
      unless occupied#([@location[0], @location[1]-1], current_board)
        new_moves << [@location[0], @location[1]+1] if @blank_board.include?([@location[0], @location[1]+1])
        if @first_move
          new_moves << [@location[0], @location[1]+2] if @blank_board.include?([@location[0], @location[1]+2])
        end
      end
      if could_attack#(current_board)
        new_moves << [@location[0]+1, @location[1]+1] if @blank_board.include?([@location[0]+1, @location[1]+1])
        new_moves << [@location[0]-1, @location[1]+1] if @blank_board.include?([@location[0]-1, @location[1]+1])
      end
    elsif @color == "black"
      unless occupied#([@location[0], @location[1]-1], current_board)
        new_moves << [@location[0], @location[1]-1] if @blank_board.include?([@location[0], @location[1]-1])
        if @first_move
          new_moves << [@location[0], @location[1]-2] if @blank_board.include?([@location[0], @location[1]-2])
        end
      end
      if could_attack#(current_board)
        new_moves << [@location[0]+1, @location[1]-1] if @blank_board.include?([@location[0]+1, @location[1]-1])
        new_moves << [@location[0]-1, @location[1]-1] if @blank_board.include?([@location[0]-1, @location[1]-1])
      end
    end 
    @potential_moves = new_moves
  end

  def could_attack#(current_board) #just a holder method for now
    #checks if there are enemies on the diagonals
    true
  end
  
  def occupied#(current_board) #just a holder method for now
    #checks if there is a piece obstructing the path
    false
  end

  def create_blank_board
    array = []
    width = 0
    while width <= 7
      height = 0
      while height <= 7
        array << [width, height]
        height += 1
      end
      width += 1 
    end
    return array
  end

end

white_pawn = Pawn.new("white", [0,1])
black_pawn = Pawn.new("black", [1,6])

white_pawn.update_moves
black_pawn.update_moves

p white_pawn.potential_moves
p black_pawn.potential_moves

black_pawn.location = [1,5]
black_pawn.first_move = false
black_pawn.update_moves
p black_pawn.potential_moves
