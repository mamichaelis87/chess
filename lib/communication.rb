module Communication 
  def intro_message
    puts "Welcome to terminal chess! It is played like normal chess, just on\n"\
         "the terminal. (you probably figured that out without my help though)\n"\
         "You will make moves based on the piece's letter/number coordinate.\n"\
         "For instance, if you want to move the left white knight, you would\n"\
         "type 'b2'.  After you select a piece, you will enter a destination.\n"\
         "Once you select a piece, there is no going back, so think beforehand!\n"\
         "Good luck, may the true chess wizard win!"
  end

  def illegal_move_alert
    puts "That is not a legal move, try a different one."
  end

  def places_in_check_alert
    puts "That move puts your king in check, try a different one."
  end

  def is_on_board(space)
    game_board = ["a1","a2","a3","a4","a5","a6","a7","a8",
                  "b1","b2","b3","b4","b5","b6","b7","b8",
                  "c1","c2","c3","c4","c5","c6","c7","c8",
                  "d1","d2","d3","d4","d5","d6","d7","d8",
                  "e1","e2","e3","e4","e5","e6","e7","e8",
                  "f1","f2","f3","f4","f5","f6","f7","f8",
                  "g1","g2","g3","g4","g5","g6","g7","g8",
                  "h1","h2","h3","h4","h5","h6","h7","h8",]
    return true if game_board.include?(space)
    false
  end

  def convert_to_coordinates(space)
    coordinates = []
    game_board = ["a1","a2","a3","a4","a5","a6","a7","a8",
                  "b1","b2","b3","b4","b5","b6","b7","b8",
                  "c1","c2","c3","c4","c5","c6","c7","c8",
                  "d1","d2","d3","d4","d5","d6","d7","d8",
                  "e1","e2","e3","e4","e5","e6","e7","e8",
                  "f1","f2","f3","f4","f5","f6","f7","f8",
                  "g1","g2","g3","g4","g5","g6","g7","g8",
                  "h1","h2","h3","h4","h5","h6","h7","h8",]
    conversion_number = game_board.index(space)
    coordinates << conversion_number.div(8)
    coordinates << conversion_number % 8 
    return coordinates
  end

  def convert_to_letter_number_format(coordinates)
    game_board = ["a1","a2","a3","a4","a5","a6","a7","a8",
                  "b1","b2","b3","b4","b5","b6","b7","b8",
                  "c1","c2","c3","c4","c5","c6","c7","c8",
                  "d1","d2","d3","d4","d5","d6","d7","d8",
                  "e1","e2","e3","e4","e5","e6","e7","e8",
                  "f1","f2","f3","f4","f5","f6","f7","f8",
                  "g1","g2","g3","g4","g5","g6","g7","g8",
                  "h1","h2","h3","h4","h5","h6","h7","h8",]
    space = coordinates[0] * 8 + coordinates[1]
    return game_board[space]
  end


  def get_piece_to_move(player)
    puts "#{player.name}, please enter the piece you would like to move."
    move = gets.chomp.downcase
    until is_on_board(move)
      puts "That is not a space on the board, please try again."
      move = gets.chomp.downcase
    end
    #converts input to [a,b]
    move = convert_to_coordinates(move)
    piece = @board[move[1]][move[0]]
    #checks if that space is occupied
    if piece
      until piece.color == player.color
        puts "#{player.name}, you do not have a piece in that space."
        move = get_piece_to_move(player)
      end
    else 
      puts "There are no pieces on that space."
      move = get_piece_to_move(player)
    end
    moves_that_put_king_in_check = []
    piece.potential_moves.each do |move|
      moves_that_put_king_in_check << move if puts_in_check(player, piece, move)
      end
    piece.potential_moves = piece.potential_moves - moves_that_put_king_in_check
    if piece.potential_moves.empty?
      puts "That piece has no legal moves, choose a different one."
      move = get_piece_to_move(player)
    end
    return move
  end

  def get_destination_of_move(player, piece)
    puts "#{player.name}, please enter where you would like to move your piece."
    move = gets.chomp.downcase
    until is_on_board(move)
      puts "That is not a space on the board, please try again."
      move = gets.chomp.downcase
    end
    #converts input to [a,b]
    move = convert_to_coordinates(move)
    #check for validity of move
    unless legal_move(player, piece, move)
      move = get_destination_of_move(player, piece)
    end
    return move
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

  def move_executed(piece, destination)
    conversion = destination #write out method to convert to letter/number format
    puts "The #{piece.name} has moved to #{conversion}."
  end

end
