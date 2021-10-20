class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate

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
end
