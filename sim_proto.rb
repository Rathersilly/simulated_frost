# frozen_string_literal: true

require 'colorize'
TEST_GRID = []
4.times do |i|
  TEST_GRID << (1..4).map { |a| a + (i * 4) }
end
ROWS = 4
COLS = 4
INTERVAL = 0.1
def draw(array)
  sleep 0.1
  # move up ROWS lines
  # print "\e[#{ROWS}F"
  array.length.times do |x|
    array.length.times do |y|
      print (array[x][y].to_s + (' ' * 3)).slice(0..2)
    end
    puts
  end
end

def start
  @grid = TEST_GRID.dup
  cell = []
  # divide into cells
  offset = 0
  draw(@grid)
  (ROWS / 2).times do |x|
    x *= 2
    (ROWS / 2).times do |y|
      print "TOP LEFT OF CELL: #{x}  #{y}  ".green

      y *= 2
      # x = -1 if x >= ROWS
      # y = -1 if y >= ROWS  # =>
      print "#{x}  #{y}\n".red

      cell = [[@grid[x][y], @grid[x][y + 1]], [@grid[x + 1][y], @grid[x + 1][y + 1]]]
      cell = manipulate_cell(cell)
      @grid[x][y] = cell[0][0]
      @grid[x][y + 1] = cell[0][1]
      @grid[x + 1][y] = cell[1][0]
      @grid[x + 1][y + 1] = cell[1][1]

      # now need to put cell into grid

      draw(cell)
    end
    sleep 0.05
  end
  draw(@grid)
end

def manipulate_cell(cell)
  # rand(2) == 0 ? cell.transpose.rotate :  cell.rotate.transpose
  #cell.transpose.rotate
  cell.rotate.transpose
end
start
