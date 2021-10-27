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

  it 'prompts the player to place their ships' do
    player = Player.new
    prompt = <<~PRMT
      I have laid out my ships on the grid.
      You now need to lay out your two ships.
      The Cruiser is three units long and the Submarine is two units long.
          1 2 3 4
        A . . . .
        B . . . .
        C . . . .
        D . . . .
    PRMT
    expect(player.setup_message).to eq(prompt)
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
  
  it 'returns a cleared board after a game over' do
    player = Player.new
    ship = Ship.new('Submarine', 2)
    cell = 'A1'
    cell_2 = 'A2'

    player.board.place(ship, [cell, cell_2])
    old_ships = player.board.ships
    player.clear_board!
    new_ships = player.board.ships
    expect(new_ships).not_to include(old_ships)
  end
end
