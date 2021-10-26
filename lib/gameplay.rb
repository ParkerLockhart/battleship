require './lib/board'

class Gameplay
  attr_reader :player, :computer

  def initialize
    @player = player
    @computer = computer
  end

  def start
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    user_input = gets.chomp

    if user_input == "p"
      computer = Computer.new
      player = Player.new
      p "Lets go!"
      player.setup
    elsif user_input == "q"
      p "See ya another time."
      exit
    else
      p "Error: invalid input. Please enter p to play or q to quit."
      start
    end
  end

  def end_game
    start
  end

end
