require_relative 'lib/game.rb'

game = Game.new
game.display_board
game.board.each do |row|
  row.each do |square|
      p square.potential_moves if square
  end
end
game.update_all_moves
game.board.each do |row|
  row.each do |square|
      p square.potential_moves if square
  end
end