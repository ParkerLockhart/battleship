require './lib/ship'

class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @fired_upon = false

  end

  def empty?
    if ship
      false
    else
      true
    end
  end

  def place_ship(input_ship)
    @ship = input_ship
  end

  def fired_upon?
    fired_upon
  end

  def fire_upon
    @fired_upon = true
    ship.hit if ship
  end
end
