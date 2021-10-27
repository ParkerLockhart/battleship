require './lib/cell'
require './lib/ship'

class Board
  attr_reader :ships, :fired_upon
  attr_accessor :render, :cells

  def initialize
    @cells = {
      'A1' => Cell.new('A1'),
      'A2' => Cell.new('A2'),
      'A3' => Cell.new('A3'),
      'A4' => Cell.new('A4'),
      'B1' => Cell.new('B1'),
      'B2' => Cell.new('B2'),
      'B3' => Cell.new('B3'),
      'B4' => Cell.new('B4'),
      'C1' => Cell.new('C1'),
      'C2' => Cell.new('C2'),
      'C3' => Cell.new('C3'),
      'C4' => Cell.new('C4'),
      'D1' => Cell.new('D1'),
      'D2' => Cell.new('D2'),
      'D3' => Cell.new('D3'),
      'D4' => Cell.new('D4')
    }

    @ships = []
  end

  def cell_status(coordinate)
    cells[coordinate].status
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def fire_upon(coordinate)
    @cells[coordinate].fire_upon
  end

  def valid_placement?(ship, coordinates)
    (coordinates.size == ship.length) &&
      linear?(coordinates.sort) &&
      (not_overlapping(coordinates).all? == true)
  end

  def adjacent?(cell_1, cell_2)
    row_adjacent?(cell_1, cell_2) ^ column_adjacent?(cell_1, cell_2)
  end

  def row_adjacent?(cell_1, cell_2)
    (cell_1[1].to_i - cell_2[1].to_i).abs == 1
  end

  def column_adjacent?(cell_1, cell_2)
    (cell_1[0].ord - cell_2[0].ord).abs == 1
  end

  def same_row?(coordinates)
    if coordinates.count == 2
      coordinates[0][0] == coordinates[1][0]
    else
      (coordinates[0][0] == coordinates[1][0]) && (coordinates[1][0] == coordinates[2][0])
    end
  end

  def same_column?(coordinates)
    (coordinates[0][1] == coordinates[1][1]) && (coordinates[1][1] == coordinates[2][1])
  end

  def linear?(coordinates)
    if coordinates.count == 2
      adjacent?(coordinates[0], coordinates[1])
    else
      (
        adjacent?(
          coordinates[0],
          coordinates[1]
        ) && adjacent?(
          coordinates[1],
          coordinates[2]
        )
      ) && (same_row?(coordinates) || same_column?(coordinates))
    end
  end

  def place(ship, coordinates)
    coordinates.each do |cell|
      cell = @cells[cell]
      cell.place_ship(ship)
    end

    @ships << ship
  end

  def not_overlapping(coordinates)
    cellsempty = []
    coordinates.each do |cell|
      cell = @cells[cell]
      cellsempty << cell.empty?
    end
    cellsempty
  end

  def render(reveal = false)
    rendered = '  1 2 3 4 '

    rendered += @cells.each_value.map do |cell|
      cell.render(reveal)
    end.join(' ')
    rendered.insert(10, "\nA ")
    rendered.insert(21, "\nB ")
    rendered.insert(32, "\nC ")
    rendered.insert(43, "\nD ")
    rendered += " \n"
  end
end
