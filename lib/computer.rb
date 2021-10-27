require './lib/ship'
require './lib/cell'
require './lib/board'

class Computer
  attr_reader :board, :cruiser, :submarine, :ships

  def initialize
    @board = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @ships = []
  end

  def clear_board!
    @board = Board.new
  end

  def setup
    setup_cruiser
    setup_submarine
  end

  def all_ships_sunk?
    ships.all? { |ship| ship.sunk? }
  end

  def setup_cruiser
    horiz = [%w[A1 A2 A3], %w[A2 A3 A4], %w[B1 B2 B3], %w[B2 B3 B4], %w[C1 C2 C3],
             %w[C2 C3 C4], %w[D1 D2 D3], %w[D2 D3 D4]]
    vert = [%w[A1 B1 C1], %w[B1 C1 D1], %w[A2 B2 C2], %w[B2 C2 D2], %w[A3 B3 C3],
            %w[B3 C3 D3], %w[A4 B4 C4], %w[B4 C4 D4]]
    possible = horiz + vert

    possible.keep_if do |coordinates|
      board.valid_placement?(@cruiser, coordinates)
    end
    ships << cruiser
    board.place(@cruiser, possible.sample)
  end

  def setup_submarine
    horiz = [%w[A1 A2], %w[A2 A3], %w[A3 A4], %w[B1 B2], %w[B2 B3], %w[B3 B4], %w[C1 C2],
             %w[C2 C3], %w[C3 C4], %w[D1 D2], %w[D2 D3], %w[D3 D4]]
    vert = [%w[A1 B1], %w[B1 C1], %w[C1 D1], %w[A2 B2], %w[B2 C2], %w[C2 D2], %w[A3 B3],
            %w[B3 C3], %w[C3 D3], %w[A4 B4], %w[B4 C4], %w[C4 D4]]
    possible = horiz + vert

    possible.keep_if do |coordinates|
      board.valid_placement?(@submarine, coordinates)
    end
    ships << submarine
    board.place(@submarine, possible.sample)
  end

  def display_board
    puts '=============COMPUTER BOARD============='
    puts board.render
  end
end
