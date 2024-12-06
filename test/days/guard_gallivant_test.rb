# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/guard_gallivant'

class AOC2024::GuardGallivantTest < Minitest::Test
  INPUT = <<~EOI
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
  EOI

  def setup
    @gg = AOC2024::GuardGallivant.new
  end

  def test_read_map
    map, start = @gg.read_map(INPUT)

    assert_equal([6, 4], start)
    assert_equal('^', map[6][4])
    assert_equal('#', map[8][0])
    assert_equal('#', map[0][4])
    assert_equal('.', map[4][5])
  end

  def test_move
    map, start = @gg.read_map(INPUT)
    row, col = @gg.move(map, start)

    assert_equal(9, row)
    assert_equal(7, col)
  end

  def test_part1
    @gg.setup(INPUT)

    assert_equal(41, @gg.part1)
  end
end
