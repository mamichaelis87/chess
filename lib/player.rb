
class Player 
  attr_accessor :name, :color, :turn
  
  def initialize(color)
    @name = get_name
    @color = color
    @turn = true
  end

  def get_name
    puts "#{@color} player, please enter your name."
    gets.chomp
  end

end
