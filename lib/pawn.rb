require_relative 'piece.rb'

class Pawn < Piece
  attr_accessor :potential_moves, :first_move, :symbol
  
  def initialize(color, location) 
    super
    @first_move = true
    @potential_moves = update_moves
    if color == "white"
      @symbol = "\u2659"
    else
      @symbol = "\u265f"
    end
  end

  def update_moves(current_board = @blank_board)
    #updates potential moves based on location and updates
    #moves up one if white, down one if black
    #moves up two if first move
    #does not yet account for en passant move
    new_moves = []
    if @color == "white"
      unless occupied(current_board, [@location[0], @location[1]+1])
        new_moves << [@location[0], @location[1]+1] if @blank_board.include?([@location[0], @location[1]+1])
        if @first_move
          unless occupied(current_board, [@location[0], @location[1]+2])
            new_moves << [@location[0], @location[1]+2] if @blank_board.include?([@location[0], @location[1]+2])
          end
        end
      end
      if could_attack_left(current_board)
        new_moves << [@location[0]-1, @location[1]+1] if @blank_board.include?([@location[0]-1, @location[1]+1])
      elsif could_attack_right(current_board)
        new_moves << [@location[0]+1, @location[1]+1] if @blank_board.include?([@location[0]+1, @location[1]+1])
      end
    elsif @color == "black"
      unless occupied(current_board, [@location[0], @location[1]-1])
        new_moves << [@location[0], @location[1]-1] if @blank_board.include?([@location[0], @location[1]-1])
        if @first_move
          unless occupied(current_board, [@location[0], @location[1] - 2])
            new_moves << [@location[0], @location[1]-2] if @blank_board.include?([@location[0], @location[1]-2])
          end
        end
      end
      if could_attack_left(current_board)
        new_moves << [@location[0]-1, @location[1]-1] if @blank_board.include?([@location[0]-1, @location[1]-1])
      elsif could_attack_right(current_board)
        new_moves << [@location[0]+1, @location[1]-1] if @blank_board.include?([@location[0]+1, @location[1]-1])
      end
    end 
    @potential_moves = new_moves
  end

  def could_attack_left(current_board)
    if @color == "white"
      if occupied(current_board, [@location[0] - 1, @location[1] + 1]) == "black"
        true
      end
    elsif @color == "black"
      if occupied(current_board, [@location[0] - 1, @location[1] - 1]) == "white"
        true
      end
    else 
      nil
    end
    # return nil if current_board == @blank_board
    # if @color == "white"
    #   piece = current_board[@location[0] - 1][@location[1] + 1]
    # else 
    #   piece = current_board[@location[0] - 1][@location[1] - 1]
    # end
    # if piece 
    #   if piece.color != @color
    #     return true
    #   end
    # else 
    #   false
    # end
  end
  
  def could_attack_right(current_board)
    if @color == "white"
      if occupied(current_board, [@location[0] + 1, @location[1] + 1]) == "black"
        true
      end
    elsif @color == "black"
      if occupied(current_board, [@location[0] + 1, @location[1] - 1]) == "white"
        true
      end
    else 
      nil
    end
  end

end

# white_pawn = Pawn.new("white", [0,1])
# black_pawn = Pawn.new("black", [1,6])
# p white_pawn.color

# white_pawn.update_moves
# black_pawn.update_moves

# p white_pawn.potential_moves
# p black_pawn.potential_moves

# black_pawn.location = [1,5]
# black_pawn.first_move = false
# black_pawn.update_moves
# p black_pawn.potential_moves
