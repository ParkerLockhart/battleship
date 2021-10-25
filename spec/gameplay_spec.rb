require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/gameplay'

RSpec.describe Gameplay do
  it 'exists' do
    gameplay = Gameplay.new
    expect(gameplay).to be_instance_of(Gameplay)
  end

  it '#greeting' do
    gameplay = Gameplay.new
    expect(gameplay.greeting).to eq("Welcome to BATTLESHIP" + "Enter p to play. Enter q to quit.")
  end

  it '#start' do

  end

  it '#setup' do

  end


end
