require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'
require_relative 'player.rb'

class Game
  attr_accessor :board

  def initialize
    intro_message
    @board = new_board
    @white = Player.new("White")
    @black = Player.new("Black")
  end
  
  #game logic methods
  def start_game
    
  end

  def turn(player)
    #ask for move
    #check to see if it is legal
    #
  end


  #board methods
  def update_all_moves
    #updates potential moves for each piece, probably will only be used
    #at the beginning of a game after set up
    @board.each do |row|
      row.each do |square|
        if square
          square.update_moves(@board)
          # p square.potential_moves
        end
      end
    end
  end

  def new_board
    new_board = [[Rook.new("white", [0,0]), Knight.new("white", [1,0]), Bishop.new("white", [2,0]), Queen.new("white", [3,0]), King.new("white", [4,0]), Bishop.new("white", [5,0]), Knight.new("white", [6,0]), Rook.new("white", [7,0])],
             [Pawn.new("white", [0,1]), Pawn.new("white", [1,1]), Pawn.new("white", [2,1]), Pawn.new("white", [3,1]), Pawn.new("white", [4,1]), Pawn.new("white", [5,1]), Pawn.new("white", [6,1]), Pawn.new("white", [7,1])],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil, nil],
             [Pawn.new("black", [0,6]), Pawn.new("black", [1,6]), Pawn.new("black", [2,6]), Pawn.new("black", [3,6]), Pawn.new("black", [4,6]), Pawn.new("black", [5,6]), Pawn.new("black", [6,6]), Pawn.new("black", [7,6])],
             [Rook.new("black", [0,7]), Knight.new("black", [1,7]), Bishop.new("black", [2,7]), Queen.new("black", [3,7]), King.new("black", [4,7]), Bishop.new("black", [5,7]), Knight.new("black", [6,7]), Rook.new("black", [7,7])]]
    return new_board
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

  #game communication methods
  def intro_message
    puts "Welcome to terminal chess! It is played like normal chess, just on"\
         "the terminal. (you probably figured that out without my help though)"\
         "You will make moves based on the piece's letter/number coordinate."\
         "For instance, if you want to move the left white knight, you would"\
         "type 'b2'.  After you select a piece, you will enter a destination."\
         "Once you select a piece, there is no going back, so think beforehand!"\
         "Good luck, may the true chess wizard win!"
  end

  def illegal_move_alert
    puts "That is not a legal move, try a different move."
  end

  def get_piece_to_move(player)
    puts "It's your turn #{player.name}."
    puts "Please enter the piece you would like to move."
    gets.chomp
  end

  def get_destination_of_move
    puts "Please enter where you would like to move your piece."
  end

  def piece_capture_message(attacking_piece, captured_piece)
    puts "The #{attacking_piece.name} has captured the #{captured_piece.name}"
  end

  def blocked_path_message
    puts "The path to that space is blocked. Try another destination."
  end

  def check_message(player)
    puts "#{player.name}, your king is in check."
  end

  def check_mate(winner, loser)
    puts "Checkmate! Congratulations #{winner.name}! You are a true chess wizard."\
         "#{loser.name}, maybe you should learn some strategy..."\
         "https://www.chess.com/terms/chess-strategy"
  end

end