require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'

class Game
  attr_accessor :board

  def initialize
    @board = new_board
  end

  def new_board
    new_board = [[Rook.new("white", [0,7]), Knight.new("white", [1,7]), Bishop.new("white", [2,7]), Queen.new("white", [3,7]), King.new("white", [4,7]), Bishop.new("white", [5,7]), Knight.new("white", [6,7]), Rook.new("white", [7,7])],
             [Pawn.new("white", [0,6]), Pawn.new("white", [1,6]), Pawn.new("white", [2,6]), Pawn.new("white", [3,6]), Pawn.new("white", [4,6]), Pawn.new("white", [5,6]), Pawn.new("white", [6,6]), Pawn.new("white", [7,6])],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [Pawn.new("black", [0,1]), Pawn.new("black", [1,1]), Pawn.new("black", [2,1]), Pawn.new("black", [3,1]), Pawn.new("black", [4,1]), Pawn.new("black", [5,1]), Pawn.new("black", [6,1]), Pawn.new("black", [7,1])],
             [Rook.new("black", [0,0]), Knight.new("black", [1,0]), Bishop.new("black", [2,0]), Queen.new("black", [3,0]), King.new("black", [4,0]), Bishop.new("black", [5,0]), Knight.new("black", [6,0]), Rook.new("black", [7,0])]]
    return new_board
  end

  def update_all_moves
    #updates potential moves for each piece, probably will only be used
    #at the beginning of a game after set up
    @board.each do |row|
      row.each do |square|
        if square
          square.update_moves(@board)
        end
      end
    end
  end

  def display_board
    row_number = 8
    @board.each do |row|
      row_display = ""
      row.each do |square|
        if square
          row_display << "#{square.symbol}|"
        else
          row_display << " |"
        end
      end
      puts "#{row_number}|#{row_display}"
      row_number -= 1
    end
    puts "  a b c d e f g h"
  end

end