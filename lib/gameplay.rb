require './lib/board'

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
      player.setup
      play
    elsif user_input == "q"
      end_game
    else
      puts "Error: invalid input. Please enter p to play or q to quit."
      start
    end
  end

  def play
    puts ""
    puts "Let's play!"
    puts ""

    end_game = false

    until end_game
      #puts computer.board.render
      puts player.board.render(true)

      player_shoots
      # computer_shoots

      if player.game_over?
        end_game = true
        puts "Game Over. I won!"
      end
    end

  end

  def player_shoots
    valid_shot = false

    puts "Enter the coordinate for your shot:"
    until valid_shot
      user_input = gets.chomp
      if player.board.valid_coordinate?(user_input)
        valid_shot = true
      else
        puts "Please enter a valid coordinate:"
      end
    end

    # Then we need to shoot the cell
    player.board.fire_upon(user_input)
  end

  def end_game
    puts "See ya another time."
    start
  end

end
