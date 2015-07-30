require 'rspec'
require_relative 'cell'

class Board
  attr_reader :rows, :columns, :cells, :cell_factory, :alive_cells

  def initialize(rows, columns, cell_factory: Cell, alive_cells: [])
    @rows = rows
    @columns = columns
    @cell_factory = cell_factory
    @cells = []
    @alive_cells = alive_cells
    (1..rows).each do |row|
      temp_row = []
      (1..columns).each do |column|
        if alive_cells.include? [row - 1 ,column - 1]
          temp_row << cell_factory.new(alive:true)
        else
          temp_row << cell_factory.new(alive:false)
        end
      end
      @cells << temp_row
    end
  end

  def neighbors(x,y)
    #push values to empty array
    # zero is limit on bottom but there are edge cases for the
    # length of the board array-- values of rows and columns
    if x > 0 && y > 0
    elsif x =< 0 && y > 0
    elsif x > 0 && y =< 0

      [cells[x - 1][y - 1],
      cells[x - 1][y],
      cells[x - 1][y + 1],
      cells[x][y - 1],
      cells[x][y + 1],
      cells[x + 1][y + 1],
      cells[x + 1][y],
      cells[x + 1 ][y - 1]]
    end
  end

  def alive_neighbors(x,y)
    neighbors(x,y).select { |neighbor| neighbor.alive? }
  end

  def next_alive_cells
    (0...rows).map do |x|
      (0...columns).map do |y|
        if cells[x][y].alive? && alive_neighbors(x,y) == 2
          [x,y]
        elsif alive_neighbors(x,y) == 3
          [x,y]
        else
          nil
        end
      end
    end.flatten.compact
  end

  def next_generation
    Board.new(rows, columns, alive_cells: next_alive_cells)
  end
end
