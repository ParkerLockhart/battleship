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

  # TODO: test these three methods
  def game_over?
    player.all_ships_sunk? || computer.all_ships_sunk?
  end

  def valid_shot?(user_input)
    computer.board.valid_coordinate?(user_input) && computer.board.cells[user_input].fired_upon? == false
  end

  def repeat_shot?(user_input)
    computer.board.valid_coordinate?(user_input) && computer.board.cells[user_input].fired_upon
  end

  def turn
    until game_over?
      valid_shot = false

      puts 'Enter the coordinate for your shot:'
      until valid_shot
        user_input = gets.chomp
        if valid_shot?(user_input)
          valid_shot = true
        elsif repeat_shot?(user_input)
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

  def clear_boards!
    player.clear_board!
    computer.clear_board!
  end

  def end_game
    if player.all_ships_sunk?
      puts 'I won!'
    elsif computer.all_ships_sunk?
      puts 'You won!'
    end
    clear_boards!
    start
  end
end
