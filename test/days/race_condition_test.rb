# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/race_condition'

class AOC2024::RaceConditionTest < Minitest::Test
  INPUT = <<~EOI
    ###############
    #...#...#.....#
    #.#.#.#.#.###.#
    #S#...#.#.#...#
    #######.#.#.###
    #######.#.#...#
    #######.#.###.#
    ###..E#...#...#
    ###.#######.###
    #...###...#...#
    #.#####.#.###.#
    #.#...#.#.#...#
    #.#.#.#.#.#.###
    #...#...#...###
    ###############
  EOI

  def setup
    @rc = AOC2024::RaceCondition.new
  end

  def test_read_map
    map, = @rc.read_map(INPUT)

    assert_equal(%w[# . . . # . . . # . . . . . #], map[1])
    assert_equal(%w[# . # . # . # . # . # # # . #], map[2])
    assert_equal('S', map[3][1])
    assert_equal('E', map[7][5])
  end

  def test_find_start_finish_points
    _, start, finish = @rc.read_map(INPUT)

    assert_equal([1, 3], start)
    assert_equal([5, 7], finish)
  end

  def test_calc_distances_from_start
    @rc.setup(INPUT)
    distances = @rc.calc_distances([1, 3])

    assert_equal(0, distances[[1, 3]])
    assert_equal(1, distances[[1, 2]])
    assert_equal(84, distances[[5, 7]])
  end

  def test_calc_distances_from_finish
    @rc.setup(INPUT)
    distances = @rc.calc_distances([5, 7])

    assert_equal(0, distances[[5, 7]])
    assert_equal(1, distances[[4, 7]])
    assert_equal(84, distances[[1, 3]])
  end

  def test_part1
    @rc.setup(INPUT)

    assert_equal(5, @rc.part1(threshold: 20))
  end
end
