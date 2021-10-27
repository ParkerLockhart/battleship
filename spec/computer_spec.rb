require './lib/ship'
require './lib/computer'

RSpec.describe Computer do
  it 'exists' do
    computer = Computer.new
    expect(computer).to be_instance_of(Computer)
  end

  it '#setup_cruiser' do
    computer = Computer.new
    computer.setup_cruiser
    expect(computer.ships.first.name).to include('Cruiser')
  end

  it '#setup_submarine' do
    computer = Computer.new
    computer.setup_submarine
    expect(computer.ships.first.name).to include('Submarine')
  end

  describe '#all_ships_sunk?' do
    context 'when ships are not sunk' do
      it 'reports that all the ships are not sunk' do
        computer = Computer.new
        ship_with_health = Ship.new('Cruiser', 3)
        computer.ships << ship_with_health
        actual = computer.all_ships_sunk?
        expected = false
        expect(actual).to eq(expected)
      end
    end

    context 'when ships are sunk' do
      it 'reports that all the ships are sunk' do
        computer = Computer.new
        ship_with_no_health = Ship.new('Cruiser', 0)
        computer.ships << ship_with_no_health
        actual = computer.all_ships_sunk?
        expected = true
        expect(actual).to eq(expected)
      end
    end

    context 'when the computer has no ships' do
      it 'reports that all the ships are sunk' do
        computer = Computer.new
        actual = computer.all_ships_sunk?
        expected = true
        expect(actual).to eq(expected)
      end
    end
  end

  describe '#cell_status' do
    context 'hit' do
      it 'returns the correct symbol' do
        computer = Computer.new
        cell = 'A1'
        cell_2 = 'A2'
        computer.board.place(computer.submarine, [cell, cell_2])
        computer.board.fire_upon(cell)
        actual = computer.cell_status(cell)
        expected = :hit
        expect(actual).to eq(expected)
      end
    end

    context 'sunk' do
      it 'returns the correct symbol' do
        computer = Computer.new
        cell = 'A1'
        cell_2 = 'A2'
        computer.board.place(computer.submarine, [cell, cell_2])
        computer.board.fire_upon(cell)
        computer.board.fire_upon(cell_2)
        actual = computer.cell_status(cell)
        expected = :sunk
        expect(actual).to eq(expected)
      end
    end

    context 'miss' do
      it 'returns the correct symbol' do
        computer = Computer.new
        cell = 'A1'
        computer.board.fire_upon(cell)

        actual = computer.cell_status(cell)
        expected = :miss
        expect(actual).to eq(expected)
      end
    end
  end
end
