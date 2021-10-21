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
    expect(board.valid_coordinate?("A1")).to eq(true)
    expect(board.valid_coordinate?("E5")).to eq(false)
  end

  it 'checks if ship placement coordinates are length of ship' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])). to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq(true)
    expect(board.valid_placement?(submarine, ["A2", "A3"])).to eq(true)
  end


end
