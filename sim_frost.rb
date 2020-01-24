# frozen_string_literal: true

# http://rubyquiz.com/quiz117.html

require 'colorize'
# can make this more elegant with procs mb - colorize colors method in hash
ROWS = 50
COLS = 50
STATES = %i[vacuum vapor frost].freeze
STATE_COLORS = { vacuum: ' ', vapor: '"', frost: '*' }.freeze
INTERVAL = 1
TEST_GRID = []
4.times do |i|
  TEST_GRID << (1..4).map { |a| a + (i*4)}
end

class Frost
  attr_accessor :grid, :delay

  def initialize(delay=0)

    @delay = delay
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
    50.times do |i|
        iterate(i % 2)
    end
  end

  def iterate(offset)
    cell = []
    # divide into cells
    (ROWS / 2).times do |x|
      x *= 2
      x += offset
      (ROWS / 2).times do |y|
        y *= 2
        y += offset
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

        cell = [[@grid[x][y], @grid[x][ny]], [@grid[nx][y], @grid[nx][ny]]]
        cell = manipulate_cell(cell)
        @grid[x][y] = cell[0][0]
        @grid[x][ny] = cell[0][1]
        @grid[nx][y] = cell[1][0]
        @grid[nx][ny] = cell[1][1]
  
      end
    end
    sleep @delay
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
delay = ARGV[0].to_i
f = Frost.new(delay)
