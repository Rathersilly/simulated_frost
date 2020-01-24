# frozen_string_literal: true

require './sim_frost.rb'
require 'colorize'


test = (1..4).to_a
array = []
4.times do |i|
  array << test.map { |a| a * (i+1)}
end
array  # => 


describe Frost do
  # describe 'manipulate_cell' do
  frost = Frost.new
  let(:clockwise) { [[3, 1][4, 2]] }
  it 'rotates cell' do
    test_cell = [[1, 2], [3, 4]]
    puts test_cell.inspect.green
    clockwise = [[3, 1], [4, 2]]
    p clockwise
    anticlockwise = [[2, 4], [1, 3]]
    expect(frost.manipulate_cell(test_cell)).to eq(clockwise).or eq(anticlockwise)
  end
  it 'makes vapor frost' do
    test_cell = [[:vapor,:frost],[:vacuum, :vapor]]
    expected = [[:frost,:frost],[:vacuum, :frost]]
    expect(frost.manipulate_cell(test_cell)).to eq(expected)
  end

end
