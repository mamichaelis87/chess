
class Rook 
  attr_accessor :color, :location, :potential_moves, :symbol, :first_move

  def initialize(color, location)
    @color = color
    @location = location 
    @blank_board = create_blank_board
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2656"
    else
      @symbol = "\u265c"
    end
    @first_move = true
  end

  def update_moves#(current_board)
    #updates potential moves based on location and updates 
    new_moves = []
    #cycle through column and add squares
      #if it is same color, stop
      #if it is enemy color, add square and then stop
      [0,1,2,3,4,5,6,7].each do |row|
        if occupied
          #if matches color then break
          #if enemy color, add to the moves and then break
        else
          new_moves << [@location[0], row]
        end
      end
      [0,1,2,3,4,5,6,7].each do |column|
        if occupied
          #if matches color then break
          #if enemy color, add to the moves and then break
        else
          new_moves << [column, @location[1]]
        end
      end
      new_moves.delete(@location)
      @potential_moves = new_moves
  end

  private 

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

black_left_rook = Rook.new("black", [0,7])
p black_left_rook.potential_moves