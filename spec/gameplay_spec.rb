require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/gameplay'

RSpec.describe Gameplay do
  it 'exists' do
    gameplay = Gameplay.new
    expect(gameplay).to be_instance_of(Gameplay)
  end

  describe '#prompt_to_play' do
    it 'returns a string instructing how to play or quit' do
      gameplay = Gameplay.new
      expect(gameplay.prompt_to_play).to eq('Enter p to play. Enter q to quit.')
    end
  end

  describe '#greeting' do
    it 'returns a string welcoming the player' do
      gameplay = Gameplay.new
      expect(gameplay.greeting).to eq('Welcome to BATTLESHIP')
    end
  end
end
