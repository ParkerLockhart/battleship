require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
      }
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    (coordinates.size == ship.length) # &&
  end
#ideas for check if coordinates are consecutive:
#split each element in coordinates array into row, column?

#row = "A".."D"
#column = 1..4
#row.to_a
#column.to_a.ord
#check if rows = consecutive
#OR columns = consecutive with each_cons(ship.length).all? maybe?

#.sort to put coordinates in order


  def adjacent?(cell_1, cell_2)
    # cell_1 is like "A1"
    # cell_2 is like "A2"
    # is the absolute value of the difference between the cell numbers equal to 1?
    row_adjacent?(cell_1, cell_2) || column_adjacent?(cell_1, cell_2)

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
    # coordinates is sometimes like [x, y, z] and sometimes like [x, y]

    # 1: Are the pairs all adjacent?
    # 2: Are the coordinates all on the same row or column

    if coordinates.count == 2
      adjacent?(coordinates[0], coordinates[1])
    else
      (adjacent?(coordinates[0], coordinates[1]) && adjacent?(coordinates[1], coordinates[2])) && (same_row?(coordinates) || same_column?(coordinates))
    end

  end


end
