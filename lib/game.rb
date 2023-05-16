require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'
require_relative 'white_player.rb'
require_relative 'black_player.rb'
require_relative 'communication.rb'

class Game
  include Communication
  attr_accessor :board, :white, :black

  def initialize
    intro_message
    @white = WhitePlayer.new
    @black = BlackPlayer.new
    @board = new_board
  end
  
  #game logic methods
  def start_game
    #while it is not over
    until game_over
      #take turn
      display_board
      take_turn
      #switch player
    end
  end

  def turn(player)
    #see if king is in check and notify player
    #ask for move
    #check to see if it is legal
      # - not occupied by own color piece
      # - does not move king into check
    #make move
    #if piece is captured, notify player
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
      #iterates over all the enemy pieces and sees if king's location
      #is in any of the potential moves
    if king.color == "white"
      @black.pieces.each do |piece|
        if piece.potential_moves.include?(king.location)
          return true
        end
      end
    elsif king.color == "black"
      @white.pieces.each do |piece|
        if piece.potential_moves.include?(king.location)
          return true
        end
      end
    else
      return false
    end
  end

  def legal_move(player, piece, move)
    #space is in piece's potential moves
    until piece.potential_moves.include?(move)
      illegal_move_alert
      get_destination_of_move
    end
    #move does not put own king in check
      #move piece
      #run in_check
      #move piece back and return result (true or false)
  end

  def execute_move(piece, destination)
    #updates the board with the move
    #changes starting location to empty
    @board[piece.location[1]][piece.location[0]] = nil
    #changes destination to include the piece
    @board[destination[1]][destination[0]] = piece

    piece.location = destination

    move_executed(piece, destination)
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
    new_board = [[@white.rook_one, @white.knight_one, @white.bishop_one, @white.queen, @white.king, @white.bishop_two, @white.knight_two, @white.rook_two],
                [@white.pawn_one, @white.pawn_two, @white.pawn_three, @white.pawn_four, @white.pawn_five, @white.pawn_six, @white.pawn_seven, @white.pawn_eight],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [@black.pawn_one, @black.pawn_two, @black.pawn_three, @black.pawn_four, @black.pawn_five, @black.pawn_six, @black.pawn_seven, @black.pawn_eight],
                [@black.rook_one, @black.knight_one, @black.bishop_one, @black.queen, @black.king, @black.bishop_two, @black.knight_two, @black.rook_two]]
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