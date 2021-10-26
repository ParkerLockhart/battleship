require './lib/board'

class Gameplay
  attr_reader :player

  def initialize
    #computer = Computer.new
    @player = Player.new
    #computer.setup_cruiser
    #computer.setup_submarine

  end

  def greeting
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
  end

  def start
    user_input = gets.to_s.chomp
    if user_input == "p"
      puts "Lets go!"
      player.setup
    elsif user_input == "q"
      end_game
    else
      puts "Error: invalid input. Please enter p to play or q to quit."
    end
  end

  def end_game
    puts "See ya another time."
  end

end
