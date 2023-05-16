require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'
require_relative 'player.rb'
require_relative 'communication.rb'

class Game
  include Communication
  attr_accessor :board

  def initialize
    intro_message
    @board = new_board
    @white = Player.new("White")
    @black = Player.new("Black")
  end
  
  #game logic methods
  def start_game
    #while it is not over
    until game_over
      #take turn
      display_board
      take_turn
    end
  end

  def turn(player)
    #ask for move
    #check to see if it is legal
      # - not occupied by own color piece
      # - does not move king into check
    #make move
    #if piece is captured, notify player
    #see if king is in check and notify player
    #update all the moves
  end

  def game_over
    #see if it is checkmate
    if checkmate?
      display_board
      return true
    #see if it is a stalemate
    elsif stalemate?
      display_board
      return true
    #if game is over, display board
    else
      return false
    end
  end

  def checkmate?
    #if king is in check
    #and all kings moves are still in check
      #iterate over moves and run in_check
    #and no piece can move to block the king
      #iterate over all player's moves and run in_check
        #this should work for final part too
    #if piece putting king in check cannot be captured
  end

  def stalemate?
    #if king is not in check but all moves place it in check
    #iterate over moves and run in_check
    #and no piece can move to block the king
      #iterate over all player's moves and run in_check
        #this should work for final part too
    #if piece putting king in check cannot be captured
  end

  def in_check(king)
    #checks to see if the king is in check
      #iterates over all the pieces on the board and sees if king's location
      #is in any of the potential moves
    @board.each do |row|
      row.each do |square|
        if square
          unless square.color == king.color
            if square.potential_moves.include?(piece.location)
              return true
            end
          end
        end
      end
    end
  end

  def legal_move(player, piece, move)
    #space is in piece's potential moves
    #move does not put own king in check
  end

  def execute_move
    #updates the board with the move
    #changes starting location to empty
    #changes destination to include the piece
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

end