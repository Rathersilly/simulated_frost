# frozen_string_literal: true

# http://rubyquiz.com/quiz117.html

require 'colorize'
# can make this more elegant with procs mb - colorize colors method in hash
ROWS = 8
COLS = 8
STATES = %i[vacuum vapor frost].freeze
STATE_COLORS = { vacuum: ' ', vapor: '"', frost: '*' }.freeze
INTERVAL = 0.2
TEST_GRID = []
4.times do |i|
  TEST_GRID << (1..4).map { |a| a + (i*4)}
end

class Frost
  attr_accessor :grid

  def initialize
    @grid = Array.new(ROWS) { Array.new(COLS) }
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        r = rand(2) # =>
        @grid[i][j] = STATES[r]
      end
    end
    # p @grid

    @grid[ROWS / 2][COLS / 2] = :frost

    print "\n"*ROWS
    draw(@grid)
    start
  end
  def start
    10.times do 

      start_time
    end
  end

  def start_time
    cell = []
    # divide into cells
    offset = 0
    (ROWS / 2).times do |x|
      x *= 2
      (ROWS / 2).times do |y|
        y *= 2
        x = -1 if x >= ROWS
        y = -1 if y >= ROWS  # => 

        cell = [[@grid[x][y], @grid[x][y + 1]], [@grid[x + 1][y], @grid[x + 1][y + 1]]]
        cell = manipulate_cell(cell)
        @grid[x][y] = cell[0][0]
        @grid[x][y + 1] = cell[0][1]
        @grid[x + 1][y] = cell[1][0]
        @grid[x + 1][y + 1]= cell[1][1]
  
        # now need to put cell into grid
      end
      sleep 0.01
    end
    sleep INTERVAL
    draw(@grid)
  end

  def manipulate_cell(cell)
    #puts "just before rotate #{cell.inspect}".green
    # draw(cell)
    if cell.flatten.include?(:frost)
      2.times do |x|
        2.times do |y|
          cell[x][y] = :frost if cell[x][y] == :vapor
        end
      end
      cell
    else
      rand(2) == 0 ? cell.transpose.rotate :  cell.rotate.transpose
    end
    # chance of icing vapor
    # chance of rotating each way(50% each)
  end
  def draw(array)
    #move up ROWS lines
    print "\e[#{ROWS}F"
    array.length.times do |x|
      array.length.times do |y|
        if array[x][y] == :vacuum
          print ' '.on_black
        elsif array[x][y] == :vapor
          print ' '.on_light_blue
        else
          print ' '.on_light_white

        end
      end
      puts
    end
  end

end
f = Frost.new
