require './lib/board'

class Gameplay
  attr_reader

  def initialize

  end

  def greeting
    p "Welcome to BATTLESHIP!"
    p "Enter p to play. Enter q to quit."
  end

  def start
    # puts "Welcome to BATTLESHIP"
    # puts "Enter p to play. Enter q to quit."
    user_input = gets.to_s.chomp
    if user_input == "p"
      p "Lets go!"
      setup
    elsif user_input == "q"
      p "See ya another time."
      end_game
    else
      p "Error: invalid input. Please enter p to play or q to quit."
      
    end
  end

  def setup
    compboard = Board.new
    playerboard = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

  end

  def end_game
  end

end
