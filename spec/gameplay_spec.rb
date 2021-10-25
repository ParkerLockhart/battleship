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
    expect(gameplay.greeting).to eq("Enter p to play. Enter q to quit.")
  end


end
