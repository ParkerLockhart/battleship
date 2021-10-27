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

  xit 'prompts the player to place their ships' do
    player = Player.new

    expect(player.setup).to eq(prompt)
  end

  xit 'lets the player place a ship on the board' do
    player = Player.new
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[C2 C3 C4])
    cell_1 = board.cells['C2']
    cell_2 = board.cells['C3']
    cell_3 = board.cells['C4']
    expect(player.ship_placement).to eq(cell_1.ship, cell_2.ship, cell_3.ship)
  end

  describe '#all_ships_sunk?' do
    context 'when ships are not sunk' do
      it 'reports that all the ships are not sunk' do
        player = Player.new
        ship_with_health = Ship.new('Cruiser', 3)
        player.ships << ship_with_health
        actual = player.all_ships_sunk?
        expected = false
        expect(actual).to eq(expected)
      end
    end
    context 'when ships are sunk' do
      it 'reports that all the ships are sunk' do
        player = Player.new
        ship_with_no_health = Ship.new('Cruiser', 0)
        player.ships << ship_with_no_health
        actual = player.all_ships_sunk?
        expected = true
        expect(actual).to eq(expected)
      end
    end

    context 'when the player has no ships' do
      it 'reports that all the ships are sunk' do
        player = Player.new
        actual = player.all_ships_sunk?
        expected = true
        expect(actual).to eq(expected)
      end
    end
  end
  describe '#cell_status' do
    context 'hit' do
      it 'returns the correct symbol' do
        player = Player.new
        ship = Ship.new('Submarine', 2)
        cell = 'A1'
        cell_2 = 'A2'
        player.board.place(ship, [cell, cell_2])
        player.board.fire_upon(cell)
        actual = player.cell_status(cell)
        expected = :hit
        expect(actual).to eq(expected)
      end
    end

    context 'sunk' do
      it 'returns the correct symbol' do
        player = Player.new
        ship = Ship.new('Submarine', 2)
        cell = 'A1'
        cell_2 = 'A2'
        player.board.place(ship, [cell, cell_2])
        player.board.fire_upon(cell)
        player.board.fire_upon(cell_2)
        actual = player.cell_status(cell)
        expected = :sunk
        expect(actual).to eq(expected)
      end
    end

    context 'miss' do
      it 'returns the correct symbol' do
        player = Player.new
        cell = 'A1'
        player.board.fire_upon(cell)
        actual = player.cell_status(cell)
        expected = :miss
        expect(actual).to eq(expected)
      end
    end
  end
end
