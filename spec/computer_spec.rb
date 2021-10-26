require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

RSpec.describe Computer do
  it 'exists' do
    computer = Computer.new
    expect(computer).to be_instance_of(Computer)
  end

  it '#setup_cruiser' do
    computer = Computer.new
    computer.setup_cruiser
    expect(computer.board.ships.to_s).to include("Cruiser")
  end

  it '#setup_submarine' do
    computer = Computer.new
    computer.setup_submarine
    expect(computer.board.ships.to_s).to include("Submarine")
  end
end
