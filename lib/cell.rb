require './lib/ship'

class Cell
  attr_reader :coordinate, :ship, :fired_upon
  attr_accessor :render

  def initialize(coordinate)
    @coordinate = coordinate
    @fired_upon = false
  end

  def empty?
    !ship
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

  def status
    if ship && ship.sunk?
      :sunk
    elsif fired_upon && ship
      :hit
    elsif fired_upon
      :miss
    end
  end

  def render(reveal = false)
    if ship && ship.sunk?
      'X'
    elsif fired_upon && ship
      'H'
    elsif fired_upon
      'M'
    elsif ship && reveal
      'S'
    else
      '.'
    end
  end
end
