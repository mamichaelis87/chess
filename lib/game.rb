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
    player = @white
    until game_over(player)
      #take turn
      display_board
      take_turn(player)
      #switch player
      player == @white ? player = @black : player = @white
    end
  end

  def take_turn(player)
    #see if king is in check and notify player
    check_message(player) if in_check(player.king)
    #ask for move
    start = get_piece_to_move(player)
    piece = @board[start[1]][start[0]]
    destination = get_destination_of_move(player, piece)
    #make move
    execute_move(start, destination)
    #if piece is captured, notify player)
    remove_piece(player, piece, destination)

    if piece.is_a?(Pawn) || piece.is_a?(Rook) || piece.is_a?(King)
      piece.first_move = false
    end
    #update all the moves
    update_all_moves
  end

  def remove_piece(player, attacking_piece, destination)
    #cycle through enemy pieces, if one had destination, change location to nil and notify player
    
    if player.color == "white"
      @black.pieces.each do |piece|
        if piece.location == destination
          @black.pieces.delete(piece)
          piece_capture_message(attacking_piece, piece)
        end
      end
    elsif player.color == "black"
      @white.pieces.each do |piece|
        if piece.location == destination
          @white.pieces.delete(piece)
          piece_capture_message(attacking_piece, piece)
        end
      end
    end
  end

  def game_over(player)
    #see if it is checkmate
    if checkmate?(player)
      puts "That's checkmate!"
      display_board
      return true
    #see if it is a stalemate
    elsif stalemate?(player)
      puts "That's a stalemate!"
      display_board
      return true
    #if game is over, display board
    else
      return false
    end
  end

  def checkmate?(player)
    #if king is in check
    return false unless in_check(player.king) 
    #in_check returns true for every potential move a player can make
    player.pieces.each do |piece|
      piece.potential_moves.each do |move|
        return false unless puts_in_check(player, piece, move)
      end
    end
    #and all kings moves are still in check
      #iterate over moves and run in_check
    #and no piece can move to block the king
      #iterate over all player's moves and run in_check
        #this should work for final part too
    #if piece putting king in check cannot be captured
    return true
  end

  def stalemate?(player)
    #if king is not in check but all moves place it in check
    return false if in_check(player.king)
    #iterate over moves and run in_check
    player.pieces.each do |piece|
      piece.potential_moves.each do |move|
        return false unless puts_in_check(player, piece, move)
      end
    end
    #and no piece can move to block the king
      #iterate over all player's moves and run in_check
        #this should work for final part too
    #if piece putting king in check cannot be captured
    return true
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
    end
    return false
  end

  def puts_in_check(player, piece, destination)
    check = false
    start = piece.location
    #makes potential move
    execute_move(start, destination)
    update_all_moves
    if in_check(player.king)
      check = true
    end
    #puts own piece back
    execute_move(destination, start) 
    #puts opponent piece back
    # if player.color == "white" 
      @black.pieces.each do |piece|
        if piece.location == destination
          @board[destination[1]][destination[0]] = piece
        end
      end
    # elsif player.color == "black"
      @white.pieces.each do |piece|
        if piece.location == destination
          @board[destination[1]][destination[0]] = piece
        end
      end
    # end
    update_all_moves
    return check
  end

  def legal_move(player, piece, move)
    #space is in piece's potential moves
    unless piece.potential_moves.include?(move)
      illegal_move_alert
      return false
    end
    #move does not put own king in check
    if puts_in_check(player, piece, move)
      places_in_check_alert
      return false
    end
    true 
  end

  def execute_move(start, destination)
    #updates the variable with the actual piece
    piece = @board[start[1]][start[0]]
    #changes starting location to empty
    @board[start[1]][start[0]] = nil
    #changes destination to include the piece
    @board[destination[1]][destination[0]] = piece

    piece.location = destination
  
  end

  #board methods
  def update_all_moves
    #updates potential moves for each piece, probably will only be used
    #at the beginning of a game after set up
    # @board.each do |row|
    #   row.each do |square|
    #     if square
    #       square.update_moves(@board)
    #       # p square.potential_moves
    #     end
    #   end
    # end
    @white.pieces.each do |piece|
      # check_moves = []
      piece.update_moves(@board) if piece.location
      # piece.potential_moves.each do |move|
      #   # check_moves << move if puts_in_check(@white, piece, move)
      # end
      # piece.potential_moves = piece.potential_moves - check_moves
    end

    @black.pieces.each do |piece|
      # check_moves = []
      piece.update_moves(@board) if piece.location
      # piece.potential_moves.each do |move|
      #   check_moves << move if puts_in_check(@black, piece, move)
      # end
      # piece.potential_moves = piece.potential_moves - check_moves
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
    @board.reverse_each do |row|
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