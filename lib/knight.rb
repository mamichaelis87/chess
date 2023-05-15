require_relative 'piece.rb'

class Knight < Piece
  attr_accessor :potential_moves

  def initialize(color, location)
    super
    @potential_moves = update_moves
  end

  def update_moves
    #updates potential moves based on location and updatesif location[0] + 2 <= 7
    new_moves = []
    new_moves << [location[0] + 2, location[1] + 1] if @blank_board.include?([location[0] + 2, location[1] + 1])
    new_moves << [location[0] + 2, location[1] - 1] if @blank_board.include?([location[0] + 2, location[1] - 1])
    new_moves << [location[0] - 2, location[1] + 1] if @blank_board.include?([location[0] - 2, location[1] + 1])
    new_moves << [location[0] - 2, location[1] - 1] if @blank_board.include?([location[0] - 2, location[1] - 1])
    new_moves << [location[0] - 1, location[1] + 2] if @blank_board.include?([location[0] - 1, location[1] + 2])
    new_moves << [location[0] - 1, location[1] - 2] if @blank_board.include?([location[0] - 1, location[1] - 2])
    new_moves << [location[0] + 1, location[1] + 2] if @blank_board.include?([location[0] + 1, location[1] + 2])
    new_moves << [location[0] + 1, location[1] - 2] if @blank_board.include?([location[0] + 1, location[1] - 2])
     
    new_moves.each do |square|
      if occupied(current_board, square) == @color
        #if same color, remove from new_moves
        new_moves.delete(square)
      end
    end
    @potential_moves = new_moves
  end

end

white_left_knight = Knight.new("white", [1,0])
p white_left_knight.potential_moves