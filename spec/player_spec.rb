require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/gameplay'
require './lib/player'

RSpec.describe Player do
  it 'exists' do
    player = Player.new
    expect(player).to be_instance_of(Player)
  end

  it 'prompts the player to place their ships' do
    player = Player.new

  expect(player.setup).to eq(prompt)
  end

  it 'lets the player place a ship on the board' do
  player = Player.new
  board = Board.new
  cruiser = Ship.new("Cruiser", 3)
  board.place(cruiser, ["C2", "C3", "C4"])
  cell_1 = board.cells["C2"]
  cell_2 = board.cells["C3"]
  cell_3 = board.cells["C4"]
  expect(player.ship_placement).to eq(cell_1.ship, cell_2.ship, cell_3.ship)

  end
end
