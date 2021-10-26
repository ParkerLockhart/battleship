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
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    p "The Cruiser is three units long and the Submarine is two units long."
    p "    1 2 3 4"
    p "  A . . . ."
    p "  B . . . ."
    p "  C . . . ."
    p "  D . . . ."
    p "Enter the squares for the Cruiser (3 spaces):"
    cruiser_coordinates = gets.to_s.chomp

    if board.valid_placement?(@cruiser, cruiser_coordinates) == false
      p "Those are invalid coordinates. Please try again:"
    else board.valid_placement? == true
      board.place(@cruiser, cruiser_coordinates)
    end

  end

end
