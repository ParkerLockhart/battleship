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

  xit 'checks if coordinates are consecutive' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
  end

  it 'validates that two adjacent cells in a row are adjacent' do
    board = Board.new
    expect(board.adjacent?("A1","A2")).to eq(true)
  end

  it 'validates that two adjacent cells in a row are adjacent in descending order' do
    board = Board.new
    expect(board.adjacent?("A2","A1")).to eq(true)
  end

  it 'reports that two non-adjacent cells in the same row are not adjacent' do
    board = Board.new
    expect(board.adjacent?("A1","A3")).to eq(false)
  end

  it 'reports that two adjacent cells are linear' do
    board = Board.new
    expect(board.linear?(["A1", "A2"])).to eq(true)
  end

  it 'reports that two non-adjacent cells are not linear' do
    board = Board.new
    expect(board.linear?(["A1", "A3"])).to eq(false)
  end

  it 'reports that three adjacent cells are linear' do
    board = Board.new
    expect(board.linear?(["A1", "A2", "A3"])).to eq(true)
  end

  it 'reports that three cells with a skipped space are not linear' do
    board = Board.new
    expect(board.linear?(["A1", "A2", "A4"])).to eq(false)
  end

  it 'reports that three cells in an L are not linear' do
    board = Board.new
    expect(board.linear?(["A1", "A2", "B2"])).to eq(false)
  end

  it 'reports that three cells in a column are linear' do
    board = Board.new
    expect(board.linear?(["A1", "B1", "C1"])).to eq(true)
  end

  it 'validates that two adjacent cells in a column are adjacent' do
    board = Board.new
    expect(board.adjacent?("A1","B1")).to eq(true)
  end

  it 'validates that two adjacent cells in a column are column adjacent' do
    board = Board.new
    expect(board.column_adjacent?("A1","B1")).to eq(true)
  end

  it 'reports that two distant cells in a column are not column adjacent' do
    board = Board.new
    expect(board.column_adjacent?("A1","C1")).to eq(false)
  end

  it 'validates that three cells are in the same row' do
    board = Board.new
    expect(board.same_row?(["A1", "A3", "A4"])).to eq(true)
  end

  it 'reports that two mixed cells are not in the same row' do
    board = Board.new
    expect(board.same_row?(["A3", "B4"])).to eq(false)
  end

  it 'reports that three mixed cells are not in the same row' do
    board = Board.new
    expect(board.same_row?(["A1", "A3", "B4"])).to eq(false)
  end

  #not diagonal test

  #not overlapping

  #place ship test

  #render test


end
