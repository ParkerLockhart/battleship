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
end
