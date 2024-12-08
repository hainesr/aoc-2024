# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/resonant_collinearity'

class AOC2024::ResonantCollinearityTest < Minitest::Test
  INPUT = <<~EOI
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
  EOI

  def setup
    @rc = AOC2024::ResonantCollinearity.new
  end

  def test_read_input
    side_length, antennae = @rc.read_input(INPUT)

    assert_equal(12, side_length)
    assert_equal(
      {
        '0' => [[1, 8], [2, 5], [3, 7], [4, 4]],
        'A' => [[5, 6], [8, 8], [9, 9]]
      },
      antennae
    )
  end

  def test_find_antinodes
    _, antennae = @rc.setup(INPUT)
    antinodes = @rc.find_antinodes(antennae)

    assert_equal(14, antinodes.size)
  end

  def test_part1
    @rc.setup(INPUT)

    assert_equal(14, @rc.part1)
  end
end
