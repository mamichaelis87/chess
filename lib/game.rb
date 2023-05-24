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
    check_message(player) if in_check(player, player.king.location)
    #ask for move
    start = get_piece_to_move(player)
    piece = @board[start[1]][start[0]]
    
    destination = get_destination_of_move(player, piece)
    #make move
    execute_move(start, destination)
    #if piece is captured, notify player)
    remove_piece(player, piece, destination)


    if piece.is_a?(Pawn)
      pawn_change
    end

    castle_moves = [[2,0], [6,0], [2,7], [6,7]]
    if piece.is_a?(King) && castle_moves.include?(destination)
      castle_rook(player, destination)
    end
    
    if piece.is_a?(Pawn) || piece.is_a?(Rook) || piece.is_a?(King)
      piece.first_move = false
    end
    #update all the moves
    update_all_moves
  end

  def castle_rook(player, destination)
    case destination
    when [2,0]
      execute_move(@white.rook_one.location, [3,0])
    when [6,0]
      execute_move(@white.rook_two.location, [5,7])
    when [2,7]
      execute_move(@black.rook_one.location, [3,7])
    when [6,7]
      execute_move(@black.rook_two.location, [5,7])
    end
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
    return false unless in_check(player, player.king.location) 
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
    return false if in_check(player, player.king.location)
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

  def in_check(player, square)
    #checks to see if the king is in check
      #iterates over all the enemy pieces and sees if king's location
      #is in any of the potential moves
    if king.color == "white"
      @black.pieces.each do |piece|
        if piece.potential_moves.include?(square)
          return true
        end
      end
    elsif king.color == "black"
      @white.pieces.each do |piece|
        if piece.potential_moves.include?(square)
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
    if in_check(player, player.king.location)
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

  def pawn_change(player, piece, destination)
    new_piece = nil
    choices = ["queen", "bishop", "knight", "rook", "pawn"]
    square = [destination[0], destination[1]]
    if player == @white && destination[1] == 7
      puts "Your pawn reached the end of the board, please \n"\
           "enter the piece you would like to change it to. \n"\
           "To keep a pawn, enter 'pawn'."
      new_piece = gets.chomp.downcase
      until choices.include?(new_piece)
        puts "That is not a valid choice, please enter a game piece.\n"\
             "(king, queen, bishop, knight, rook, or pawn)"
        new_piece = gets.chomp.downcase
      end

      case new_piece
      when "queen"
        new_piece = Queen.new("white", square)
      when "bishop"
        new_piece = Bishop.new("white", square)
      when "knight"
        new_piece = Knight.new("white", square)
      when "rook"
        new_piece = Rook.new("white", square)
        new_piece.first_move = false
      else 
        new_piece = piece
      end
      @board[square[1]][square[0]] = new_piece
      @white.pieces = @white.pieces - piece 
      @white.pieces << new_piece
    elsif player == @black&& destination[1] == 0
      puts "Your pawn reached the end of the board, please \n"\
           "enter the piece you would like to change it to. \n"\
           "To keep a pawn, enter 'pawn'."
      new_piece = gets.chomp.downcase
      until choices.include?(new_piece)
        puts "That is not a valid choice, please enter a game piece.\n"\
             "(queen, bishop, knight, rook, or pawn)"
        new_piece = gets.chomp.downcase
      end

      case new_piece
      when "queen"
        new_piece = Queen.new("black", square)
      when "bishop"
        new_piece = Bishop.new("black", square)
      when "knight"
        new_piece = Knight.new("black", square)
      when "rook"
        new_piece = Rook.new("black", square)
        new_piece.first_move = false
      else 
        new_piece = piece
      end
      @board[square[1]][square[0]] = new_piece
      @black.pieces = @black.pieces - piece 
      @black.pieces << new_piece
    end
  end

  def add_castle_moves(player)
    #if it is king and rooks first move  
    #if no pieces are between king and rook
    #if king is not in check
    return if in_check(player, player.king.location)

    if player == @white && player.king.first_move
      if player.rook_one.first_move && @board[0][1] == nil && @board[0][2] == nil && @board[0][3] == nil
        unless in_check(player, [[3,0]]) || in_check(player, [2,0])
          player.king.potential_moves << [2, 0]
        end
      end
      if player.rook_two.first_move && @board[0][5] == nil && @board[0][6] == nil
        unless in_check(player, [[5,0]]) || in_check(player, [6,0])  
          player.king.potential_moves << [6, 0]
        end
      end
    elsif player == @black && player.king.first_move
      if player.rook_one.first_move && @board[7][1] == nil && @board[7][2] == nil && @board[7][3] == nil
        unless in_check(player, [2,7]) || in_check(player, [3,7])
        player.king.potential_moves << [2, 7]
        end
      end
      if player.rook_two.first_move && @board[7][5] == nil && @board[7][6] == nil
        unless in_check(player, [[5,7]]) || in_check(player, [6,7])
        player.king.potential_moves << [6, 7]
        end
      end
    end
    #if no spaces the king passes over are in check
    #king moves two spaces toward rook, rook moves to the opposite side of the king
  end

  def en_passant(player, piece, destination)
    #if enemy pawn skips over possible attack to move next to you,
    #you can move behind that pawn and capture it in the process
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
      piece.update_moves(@board) 
      # piece.potential_moves.each do |move|
      #   # check_moves << move if puts_in_check(@white, piece, move)
      # end
      # piece.potential_moves = piece.potential_moves - check_moves
    end

    @black.pieces.each do |piece|
      # check_moves = []
      piece.update_moves(@board) 
      # piece.potential_moves.each do |move|
      #   check_moves << move if puts_in_check(@black, piece, move)
      # end
      # piece.potential_moves = piece.potential_moves - check_moves
    end
    add_castle_moves(@white)
    add_castle_moves(@black)
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