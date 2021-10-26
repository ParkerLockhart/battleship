require './lib/cell'
require './lib/ship'
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
    p prompt
    p ship_placement
  end

  def ship_placement

    p "Enter the squares for the Cruiser (3 spaces):"
    user_placement = gets.to_s.chomp
    if board.valid_placement? == false
      p "Invalid placement, try again."
    else board.valid_placement? == true
      board.place(@cruiser, user_placement.split)
    end

  end

end
