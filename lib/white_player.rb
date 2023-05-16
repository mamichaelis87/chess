require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'

class WhitePlayer 
  attr_accessor :name, :color, :turn, :rook_one, :knight_one, :bishop_one, 
                :queen, :king, :bishop_two, :knight_two, :rook_two,
                :pawn_one, :pawn_two, :pawn_three, :pawn_four,
                :pawn_five, :pawn_six, :pawn_seven, :pawn_eight
  
  def initialize
    @name = get_name
    @color = "white"
    @turn = true
    @rook_one = Rook.new("white", [0,0])
    @knight_one = Knight.new("white", [1,0])
    @bishop_one = Bishop.new("white", [2,0])
    @queen = Queen.new("white", [3,0])
    @king = King.new("white", [4,0])
    @bishop_two = Bishop.new("white", [5,0])
    @knight_two = Knight.new("white", [6,0])
    @rook_two = Rook.new("white", [7,0])
    @pawn_one = Pawn.new("white", [0,1])
    @pawn_two = Pawn.new("white", [1,1])
    @pawn_three = Pawn.new("white", [2,1])
    @pawn_four = Pawn.new("white", [3,1])
    @pawn_five = Pawn.new("white", [4,1])
    @pawn_six = Pawn.new("white", [5,1])
    @pawn_seven = Pawn.new("white", [6,1])
    @pawn_eight = Pawn.new("white", [7,1])
    @pieces = [@rook_one, @knight_one, @bishop_one, @queen, @king, @bishop_two,
              @knight_two, @rook_two, @pawn_one, @pawn_two, @pawn_three, @pawn_four,
              @pawn_five, @pawn_six, @pawn_seven, @pawn_eight]
  end

  def get_name
    puts "White player, please enter your name."
    gets.chomp
  end

end
