# frozen_string_literal: true

require 'colorize'
TEST_GRID = [].freeze
4.times do |i|
  TEST_GRID << (1..4).map { |a| a + (i * 4) }
end
ROWS = 4
COLS = 4
INTERVAL = 0.1
def draw(array)
  # move up ROWS lines
  # print "\e[#{ROWS}F"
  array.length.times do |x|
    array.length.times do |y|
      print (array[x][y].to_s + (' ' * 3)).slice(0..2)
    end
    puts
  end
  puts
end

def iterate(offset)
  @grid = TEST_GRID.dup
  cell = []
  # divide into cells
  draw(@grid)
  (ROWS / 2).times do |x|
    x *= 2
    x += offset
    (ROWS / 2).times do |y|
      # print "TOP LEFT OF CELL: #{x}  #{y}  -> ".green

      y *= 2
      y += offset
      # print "#{x}  #{y}\n".red
      nx = if x + 1 >= ROWS
             0
           else
             x + 1
           end
      ny = if y + 1 >= ROWS
             0
           else
             y + 1
           end

      # print "BOTTOM RIGHT OF CELL: #{nx}  #{ny}\n".blue
      cell = [[@grid[x][y], @grid[x][ny]], [@grid[nx][y], @grid[nx][ny]]]
      draw(cell)
      cell = manipulate_cell(cell)
      draw(cell)
      sleep 1
      @grid[x][y] = cell[0][0]
      @grid[x][ny] = cell[0][1]
      @grid[nx][y] = cell[1][0]
      @grid[nx][ny] = cell[1][1]

      # now need to put cell into grid
    end
    sleep 0.05
  end
  draw(@grid)
  puts
end

def manipulate_cell(cell)
  # rand(2) == 0 ? cell.transpose.rotate :  cell.rotate.transpose
  # cell.transpose.rotate
  cell.rotate.transpose
end
2.times do |i|
  iterate(i % 2)
  puts
end
