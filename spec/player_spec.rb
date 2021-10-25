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

  it 'lets the player place three ships on the board' do
    
  end
end
