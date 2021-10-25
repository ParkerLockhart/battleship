require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/gameplay'

Rspec.describe Player do
  it 'exists' do
    player = Player.new
    expect(player).to be_instance_of(Player)
  end
end 
