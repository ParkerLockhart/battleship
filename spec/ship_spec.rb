require './lib/ship'

describe Ship do
  it 'exists'do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser).to be_instance_of(Ship)
  end

  describe '#health' do
    it 'returns ship health status' do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser.health).to eq(3)
    end
  end

end
