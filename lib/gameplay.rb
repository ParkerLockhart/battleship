require './lib/board'
require './lib/player'
require './lib/computer'

class Gameplay
  InvalidShotError = Class.new(StandardError)
  attr_reader :player, :computer

  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def start
    puts greeting
    puts prompt_to_play
    user_input = gets.chomp

    if user_input == 'p'
      puts 'Lets go!'
      computer.setup
      player.setup
      turn
    elsif user_input == 'q'
      exit
    else
      puts 'Error: invalid input. Please enter p to play or q to quit.'
      start
    end
  end

  def greeting
    'Welcome to BATTLESHIP'
  end

  def prompt_to_play
    'Enter p to play. Enter q to quit.'
  end

  def turn
    until player.all_ships_sunk? || computer.all_ships_sunk?
      valid_shot = false

      puts 'Enter the coordinate for your shot:'
      until valid_shot
        user_input = gets.chomp
        if computer.board.valid_coordinate?(user_input) && computer.board.cells[user_input].fired_upon? == false
          valid_shot = true
        elsif computer.board.valid_coordinate?(user_input) && computer.board.cells[user_input].fired_upon
          puts "You have already fired on that coordinate. Please choose a coordinate you haven't already fired upon:"
        else
          puts 'Please enter a valid coordinate:'
        end
      end

      computer.board.fire_upon(user_input)

      shot = player.board.cells.keys.sample

      shot = player.board.cells.keys.sample while player.board.cells[shot].fired_upon?

      player.board.fire_upon(shot)

      computer.display_board
      player.display_board

      case computer.cell_status(user_input)
      when :sunk
        puts "Your shot on #{user_input} sunk my ship!"
      when :hit
        puts "Your shot on #{user_input} was a hit!"
      when :miss
        puts "Your shot on #{user_input} was a miss."
      else
        raise InvalidShotError
      end

      case player.cell_status(shot)
      when :sunk
        puts "My shot on #{shot} sunk your ship!"
      when :hit
        puts "My shot on #{shot} was a hit!"
      when :miss
        puts "My shot on #{shot} was a miss."
      else
        raise InvalidShotError
      end
    end
    end_game
  end

  def clear_boards!
    player.clear_board!
    computer.clear_board!
  end

  def end_game
    if player.board.ships.all? { |ship| ship.sunk? }
      puts 'I won!'
    elsif computer.board.ships.all? { |ship| ship.sunk? }
      puts 'You won!'
    end
    clear_boards!
    start
  end
end
