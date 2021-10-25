require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/gameplay'

Rspec.describe Computer do
  it 'exists' do
    computer = Computer.new
    expect(computer).to be_instance_of(Computer)
  end
end
