require './lib/cell'
require './lib/ship'
require './lib/board'

RSpec.describe Board do
  it 'exists' do
    board = Board.new
    expect(board).to be_instance_of(Board)
  end

  it 'has cells' do
    board = Board.new
    expect(board.cells).to be_kind_of(Hash)
    expect(board.cells.size).to eq(16)
  end

  it 'checks if a coordinate is valid' do
    board = Board.new
    expect(board.valid_coordinate?('A1')).to eq(true)
    expect(board.valid_coordinate?('E5')).to eq(false)
  end

  it 'checks if ship placement coordinates are length of ship' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    expect(board.valid_placement?(cruiser, %w[A1 A2])).to eq(false)
    expect(board.valid_placement?(submarine, %w[A2 A3 A4])).to eq(false)
    expect(board.valid_placement?(cruiser, %w[A1 A2 A3])).to eq(true)
    expect(board.valid_placement?(submarine, %w[A2 A3])).to eq(true)
  end

  it 'checks if coordinates are consecutive' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    expect(board.valid_placement?(cruiser, %w[A1 A2 A4])).to eq(false)
    expect(board.valid_placement?(submarine, %w[A1 C1])).to eq(false)
  end

  it 'validates the placements of a cruiser with descending coordinates' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    expect(board.valid_placement?(cruiser, %w[A3 A2 A1])).to eq(true)
  end

  it 'validates that two adjacent cells in a row are adjacent' do
    board = Board.new
    expect(board.adjacent?('A1', 'A2')).to eq(true)
  end

  it 'validates that two adjacent cells in a row are adjacent in descending order' do
    board = Board.new
    expect(board.adjacent?('A2', 'A1')).to eq(true)
  end

  it 'reports that two non-adjacent cells in the same row are not adjacent' do
    board = Board.new
    expect(board.adjacent?('A1', 'A3')).to eq(false)
  end

  it 'reports that two adjacent cells are linear' do
    board = Board.new
    expect(board.linear?(%w[A1 A2])).to eq(true)
  end

  it 'reports that two non-adjacent cells are not linear' do
    board = Board.new
    expect(board.linear?(%w[A1 A3])).to eq(false)
  end

  it 'reports that three adjacent cells are linear' do
    board = Board.new
    expect(board.linear?(%w[A1 A2 A3])).to eq(true)
  end

  it 'reports that three cells with a skipped space are not linear' do
    board = Board.new
    expect(board.linear?(%w[A1 A2 A4])).to eq(false)
  end

  it 'reports that three cells in an L are not linear' do
    board = Board.new
    expect(board.linear?(%w[A1 A2 B2])).to eq(false)
  end

  it 'reports that three cells in a column are linear' do
    board = Board.new
    expect(board.linear?(%w[A1 B1 C1])).to eq(true)
  end

  it 'validates that two adjacent cells in a column are adjacent' do
    board = Board.new
    expect(board.adjacent?('A1', 'B1')).to eq(true)
  end

  it 'validates that two adjacent cells in a column are column adjacent' do
    board = Board.new
    expect(board.column_adjacent?('A1', 'B1')).to eq(true)
  end

  it 'reports that two distant cells in a column are not column adjacent' do
    board = Board.new
    expect(board.column_adjacent?('A1', 'C1')).to eq(false)
  end

  it 'validates that three cells are in the same row' do
    board = Board.new
    expect(board.same_row?(%w[A1 A3 A4])).to eq(true)
  end

  it 'reports that two mixed cells are not in the same row' do
    board = Board.new
    expect(board.same_row?(%w[A3 B4])).to eq(false)
  end

  it 'reports that three mixed cells are not in the same row' do
    board = Board.new
    expect(board.same_row?(%w[A1 A3 B4])).to eq(false)
  end

  it 'reports if the coordinates are diagonal' do
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    board = Board.new
    expect(board.valid_placement?(cruiser, %w[A1 B2 C3])).to eq(false)
    expect(board.valid_placement?(submarine, %w[B2 C3])).to eq(false)
  end

  it 'reports that placement is valid, once more' do
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    board = Board.new
    expect(board.valid_placement?(submarine, %w[A1 A2])).to eq(true)
    expect(board.valid_placement?(cruiser, %w[B1 C1 D1])).to eq(true)
  end

  it 'places ship in cells on board' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])
    cell_1 = board.cells['A1']
    cell_2 = board.cells['A2']
    cell_3 = board.cells['A3']
    expect(cell_3.ship).to eq(cell_2.ship)
  end

  it 'doesnt overlap' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])
    submarine = Ship.new('Submarine', 2)
    expect(board.valid_placement?(submarine, %w[A1 B1])).to eq(false)
  end

  it 'returns a visual of the game board' do
    board = Board.new
    expect(board.render).to eq("  1 2 3 4 \n" +
       "A . . . . \n" +
       "B . . . . \n" +
       "C . . . . \n" +
       "D . . . . \n")
  end

  it 'shows where the ship is on the board' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])
    cell_1 = board.cells['A1']
    cell_2 = board.cells['A2']
    cell_3 = board.cells['A3']
    expect(board.render(true)).to eq("  1 2 3 4 \n" +
      "A S S S . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n")
  end

  it 'shows where if a ship is hit' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[C2 C3 C4])
    cell_1 = board.cells['C2']
    cell_2 = board.cells['C3']
    cell_3 = board.cells['C4']
    cell_3.fire_upon
    expect(board.render(true)).to eq("  1 2 3 4 \n" +
      "A . . . . \n" +
      "B . . . . \n" +
      "C . S S H \n" +
      "D . . . . \n")
  end
end
