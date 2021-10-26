require './lib/board'
require './lib/player'
require './lib/computer'

class Gameplay
  attr_reader :player, :computer

  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def start
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    user_input = gets.chomp

    if user_input == "p"
      puts "Lets go!"
      computer.setup
      player.setup
      turn
    elsif user_input == "q"
      exit
    else
      puts "Error: invalid input. Please enter p to play or q to quit."
      start
    end
  end

  def turn
    until player.board.ships.all?{|ship| ship.sunk?} || computer.board.ships.all?{|ship| ship.sunk?}
      valid_shot = false

      puts "Enter the coordinate for your shot:"
      until valid_shot
        user_input = gets.chomp
        if computer.board.valid_coordinate?(user_input) && computer.board.cells[user_input].fired_upon? == false
          valid_shot = true
        elsif computer.board.valid_coordinate?(user_input) && computer.board.cells[user_input].fired_upon
          puts "You have already fired on that coordinate. Please choose a coordinate you haven't already fired upon:"
        else
          puts "Please enter a valid coordinate:"
        end
      end

      computer.board.fire_upon(user_input)


      shot = player.board.cells.keys.sample

      while player.board.cells[shot].fired_upon?
        shot = player.board.cells.keys.sample
      end

      player.board.fire_upon(shot)

      computer.display_board
      player.display_board

      if computer.board.cells[user_input].render == "X"
        puts "Your shot on #{user_input} sunk my ship!"
      elsif computer.board.cells[user_input].render == "H"
        puts "Your shot on #{user_input} was a hit!"
      elsif computer.board.cells[user_input].render == "M"
        puts "Your shot on #{user_input} was a miss."
      end

      if player.board.cells[shot].render == "X"
        puts "My shot on #{shot} sunk your ship!"
      elsif player.board.cells[shot].render == "H"
        puts "My shot on #{shot} was a hit!"
      elsif player.board.cells[shot].render == "M"
        puts "My shot on #{shot} was a miss."
      end
    end
    end_game
  end

  def end_game
    if player.board.ships.all?{|ship| ship.sunk?}
      puts "I won!"
    elsif computer.board.ships.all?{|ship| ship.sunk?}
      puts "You won!"
    end
    start
  end
end
