require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'

class Game

  def initialize
    @board = new_board
  end

  def new_board
    board = [[Rook.new("black", [0,7]), Knight.new("black", [1,7]), Bishop.new("black", [2,7]), Queen.new("black", [3,7]), King.new("black", [4,7]), Bishop.new("black", [5,7]), Knight.new("black", [6,7]), Rook.new("black", [7,7])],
             [Pawn.new("black", [0,6]), Pawn.new("black", [1,6]), Pawn.new("black", [2,6]), Pawn.new("black", [3,6]), Pawn.new("black", [4,6]), Pawn.new("black", [5,6]), Pawn.new("black", [6,6]), Pawn.new("black", [7,6])],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [Pawn.new("white", [0,1]), Pawn.new("white", [1,1]), Pawn.new("white", [2,1]), Pawn.new("white", [3,1]), Pawn.new("white", [4,1]), Pawn.new("white", [5,1]), Pawn.new("white", [6,1]), Pawn.new("white", [7,1])],
             [Rook.new("white", [0,0]), Knight.new("white", [1,0]), Bishop.new("white", [2,0]), Queen.new("white", [3,0]), King.new("white", [4,0]), Bishop.new("white", [5,0]), Knight.new("white", [6,0]), Rook.new("white", [7,0])]]
    return board
  end

  def display_board
    row_number = 8
    @board.each do |row|
      puts "#{row_number}|"
      row_number -= 1
      row.each do |square|
        if square
          puts "#{square.symbol}"
        else
          puts "  "
        end
      end
    end
  end

  end
end