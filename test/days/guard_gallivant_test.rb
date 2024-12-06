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
    corners, loop = @gg.move(map, start)

    refute(loop)
    assert_equal(12, corners.size)
  end

  def test_move_with_loop
    map, start = @gg.read_map(INPUT)
    map[6][3] = '#'
    corners, loop = @gg.move(map, start)

    assert(loop)
    assert_equal(4, corners.size)
  end

  def test_visited
    two_corners = Set[[[6, 4], 0], [[1, 4], 0]]
    twelve_corners = Set[
      [[6, 4], 0], [[1, 4], 0], [[1, 8], 1], [[6, 8], 2],
      [[6, 2], 3], [[4, 2], 0], [[4, 6], 1], [[8, 6], 2],
      [[8, 1], 3], [[7, 1], 0], [[7, 7], 1], [[9, 7], 2]
    ]

    assert_equal(
      [[1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4]],
      @gg.visited(two_corners)
    )
    assert_equal(41, @gg.visited(twelve_corners).size)
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
