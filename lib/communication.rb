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
    puts "That is not a legal move, try a different move."
  end

  def get_piece_to_move(player)
    puts "It's your turn #{player.name}."
    puts "Please enter the piece you would like to move."
    gets.chomp
    #converts input to [a,b]
  end

  def get_destination_of_move
    puts "Please enter where you would like to move your piece."
    #converts input to [a,b]
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
