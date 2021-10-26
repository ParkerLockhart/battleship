require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/gameplay'

class Player
  attr_reader :board, :cruiser, :submarine
  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def setup
    prompt = "I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long.
        1 2 3 4
      A . . . .
      B . . . .
      C . . . .
      D . . . ."
    puts prompt
    ship_placement
  end

  def ship_placement
    cruiser_placed = false

    until cruiser_placed
      puts "Enter the squares for the Cruiser (3 spaces):"
      user_placement = gets.to_s.chomp # A1 A2 A3
      ship = Ship.new("Cruiser", 3)
      coordinates = user_placement.split

      if board.valid_placement?(ship, coordinates)
        board.place(ship, coordinates)
        cruiser_placed = true
      else
        puts "Invalid placement, try again."
      end
    end

    puts board.render(true)

    submarine_placed = false
    until submarine_placed
      puts "Enter the squares for the Submarine (2 spaces):"
      user_placement = gets.to_s.chomp # A1 A2 A3
      ship = Ship.new("Submarine", 2)
      coordinates = user_placement.split

      if board.valid_placement?(ship, coordinates)
        board.place(ship, coordinates)
        submarine_placed = true
      else
        puts "Invalid placement, try again."
      end

      puts "Ready to begin. Your board looks like this:"
      puts ""
      puts board.render(true)
    end
  end

  def display_board
    puts "==============PLAYER BOARD=============="
    puts board.render(true)
  end 
end
