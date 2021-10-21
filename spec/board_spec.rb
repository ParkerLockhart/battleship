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
end
