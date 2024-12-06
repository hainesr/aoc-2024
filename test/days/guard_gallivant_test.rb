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
    visited, loop = @gg.move(map, start)

    refute(loop)
    # 55 because `move` doesn't filter out multiple visits to the same cell.
    assert_equal(55, visited.size)
  end

  def test_move_with_loop
    map, start = @gg.read_map(INPUT)
    map[6][3] = '#'
    visited, loop = @gg.move(map, start)

    assert(loop)
    # 22 because `move` doesn't filter out multiple visits to the same cell.
    assert_equal(22, visited.size)
  end

  def test_part1
    @gg.setup(INPUT)

    assert_equal(41, @gg.part1)
  end

  def test_part2
    @gg.setup(INPUT)
    @gg.part1 # Cheeky dependency on part 1 to set up the visited array.

    assert_equal(6, @gg.part2)
  end
end
