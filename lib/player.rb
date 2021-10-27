require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/gameplay'

class Player
  attr_reader :board, :ships

  def initialize
    @board = Board.new
    @ships = []
  end

  def setup_message
    <<~MSG
      I have laid out my ships on the grid.
      You now need to lay out your two ships.
      The Cruiser is three units long and the Submarine is two units long.
          1 2 3 4
        A . . . .
        B . . . .
        C . . . .
        D . . . .
    MSG
  end

  def setup
    puts setup_message
    ship_placement
  end

  # TODO: write test
  def clear_board!
    @board = Board.new
  end

  def cell_status(coordinate)
    board.cell_status(coordinate)
  end

  def all_ships_sunk?
    ships.all? { |ship| ship.sunk? }
  end

  def ship_placement
    cruiser_placed = false

    until cruiser_placed
      puts 'Enter the squares for the Cruiser (3 spaces):'
      user_placement = gets.to_s.chomp
      ship = Ship.new('Cruiser', 3)
      coordinates = user_placement.split

      if board.valid_placement?(ship, coordinates)
        board.place(ship, coordinates)
        cruiser_placed = true
        ships << ship
      else
        puts 'Invalid placement, try again.'
      end
    end

    puts board.render(true)

    submarine_placed = false
    until submarine_placed
      puts 'Enter the squares for the Submarine (2 spaces):'
      user_placement = gets.to_s.chomp
      ship = Ship.new('Submarine', 2)
      coordinates = user_placement.split

      if board.valid_placement?(ship, coordinates)
        board.place(ship, coordinates)
        submarine_placed = true
        ships << ship
      else
        puts 'Invalid placement, try again.'
      end

      puts 'Ready to begin. Your board looks like this:'
      puts ''
      puts board.render(true)
    end
  end

  def display_board
    puts '==============PLAYER BOARD=============='
    puts board.render(true)
  end
end
