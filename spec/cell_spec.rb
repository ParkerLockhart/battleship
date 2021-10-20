require './lib/cell'
require './lib/ship'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new("B4")
    expect(cell).to be_instance_of(Cell)
  end

  it 'has a coordinate' do
    cell = Cell.new("B4")
    expect(cell.coordinate).to eq("B4")
  end

  it 'tells if the cell has a ship' do
    cell = Cell.new("B4")
    expect(cell.ship).to eq(nil)
  end

  it 'tells if the cell is empty' do
    cell = Cell.new("B4")
    expect(cell.empty?).to eq(true)
  end

  it 'places a ship on a cell' do
    cell = Cell.new("B4")
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it 'tracks being fired upon' do
    cell = Cell.new("B4")
    expect(cell.fired_upon?).to eq(false)
    cell.fire_upon
    expect(cell.fired_upon?).to eq(true)
  end

  it 'damages a ship when the cell is fired upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    expect(cruiser.health).to eq(3)
    cell.fire_upon
    expect(cruiser.health).to eq(2)
  end

  describe '#render' do
    it 'shows a . for an unhit and empty cell' do
      cell = Cell.new("B4")
      expect(cell.render).to eq(".")
    end

    it 'shows an M for a miss on an empty cell' do
      cell = Cell.new("B4")
      cell.fire_upon
      expect(cell.render).to eq("M")
    end

    it 'shows a . for an unhit cell with a ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.render).to eq(".")
    end

    it 'shows a S for an unhit cell with a ship and the reveal code' do
      cell = Cell.new("B4")
      cruiser = Ship.new("cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.render(true)).to eq("S")
    end

    it 'shows an H for a hit cell with a ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("cruiser", 3)
      cell.place_ship(cruiser)
      cell.fire_upon
      expect(cell.render(true)).to eq("H")
    end

    it 'shows an X for a sunken ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("cruiser", 3)
      cell.place_ship(cruiser)
      cell.fire_upon
      cruiser.hit

      expect(cell.render(true)).to eq("H")
      cruiser.hit
      expect(cell.render(true)).to eq("X")
    end
  end
end
