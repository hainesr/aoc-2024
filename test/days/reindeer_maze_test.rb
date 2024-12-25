# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/reindeer_maze'

class AOC2024::ReindeerMazeTest < Minitest::Test
  INPUT = <<~EOI
    ###############
    #.......#....E#
    #.#.###.#.###.#
    #.....#.#...#.#
    #.###.#####.#.#
    #.#.#.......#.#
    #.#.#####.###.#
    #...........#.#
    ###.#.#####.#.#
    #...#.....#.#.#
    #.#.#.###.#.#.#
    #.....#...#.#.#
    #.###.#.#.#.#.#
    #S..#.....#...#
    ###############
  EOI

  INPUT2 = <<~EOI
    #################
    #...#...#...#..E#
    #.#.#.#.#.#.#.#.#
    #.#.#.#...#...#.#
    #.#.#.#.###.#.#.#
    #...#.#.#.....#.#
    #.#.#.#.#.#####.#
    #.#...#.#.#.....#
    #.#.#####.#.###.#
    #.#.#.......#...#
    #.#.###.#####.###
    #.#.#...#.....#.#
    #.#.#.#####.###.#
    #.#.#.........#.#
    #.#.#.#########.#
    #S#.............#
    #################
  EOI

  def setup
    @rm = AOC2024::ReindeerMaze.new
  end

  def test_read_map
    map, start, finish = @rm.read_map(INPUT)

    assert_equal(15, map.length)
    assert_equal(15, map[0].length)
    assert_equal('#', map[0][0])
    assert_equal('E', map[1][13])
    assert_equal('S', map[13][1])
    assert_equal('.', map[13][13])
    assert_equal(AOC2024::ReindeerMaze::Node.new(1, 13), start)
    assert_equal(AOC2024::ReindeerMaze::Node.new(13, 1), finish)
  end

  def test_part1
    @rm.setup(INPUT)

    assert_equal(7036, @rm.part1)
  end

  def test_part1_input2
    @rm.setup(INPUT2)

    assert_equal(11_048, @rm.part1)
  end
end
