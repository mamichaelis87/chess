require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'

class BlackPlayer 
  attr_accessor :name, :color, :turn, :rook_one, :knight_one, :bishop_one, 
                :queen, :king, :bishop_two, :knight_two, :rook_two,
                :pawn_one, :pawn_two, :pawn_three, :pawn_four,
                :pawn_five, :pawn_six, :pawn_seven, :pawn_eight
  
  def initialize
    @name = get_name
    @color = "black"
    @turn = false
    @rook_one = Rook.new("black", [0,7])
    @knight_one = Knight.new("black", [1,7])
    @bishop_one = Bishop.new("black", [2,7])
    @queen = Queen.new("black", [3,7])
    @king = King.new("black", [4,7])
    @bishop_two = Bishop.new("black", [5,7])
    @knight_two = Knight.new("black", [6,7])
    @rook_two = Rook.new("black", [7,7])
    @pawn_one = Pawn.new("black", [0,6])
    @pawn_two = Pawn.new("black", [1,6])
    @pawn_three = Pawn.new("black", [2,6])
    @pawn_four = Pawn.new("black", [3,6])
    @pawn_five = Pawn.new("black", [4,6])
    @pawn_six = Pawn.new("black", [5,6])
    @pawn_seven = Pawn.new("black", [6,6])
    @pawn_eight = Pawn.new("black", [7,6])
    @pieces = [@rook_one, @knight_one, @bishop_one, @queen, @king, @bishop_two,
      @knight_two, @rook_two, @pawn_one, @pawn_two, @pawn_three, @pawn_four,
      @pawn_five, @pawn_six, @pawn_seven, @pawn_eight]
  end

  def get_name
    puts "Black player, please enter your name."
    gets.chomp
  end

end