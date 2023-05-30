require_relative 'lib/game.rb'


game = Game.new
game.start_game

#testing for in_check
# game.update_all_moves
# p game.in_check(game.white.king)


#testing for execute move
# game.display_board
# p game.white.knight_one.location
# p game.puts_in_check(game.white, game.white.knight_one, [0,2])
# game.execute_move([1,0], [0,2])
# p game.white.knight_one.location
# game.display_board

#testing for update_all_moves
# game.white.pieces.each do |piece|
#     puts piece.name 
#     p piece.potential_moves
#   end
# game.update_all_moves
# p "now show updated moves"
# game.white.pieces.each do |piece|
#     puts piece.name 
#     p piece.potential_moves
#   end
