# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/hoof_it'

class AOC2024::HoofItTest < Minitest::Test
  INPUT = <<~EOI
    0123
    1234
    8765
    9876
  EOI

  INPUT2 = <<~EOI
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
  EOI

  def setup
    @hi = AOC2024::HoofIt.new
  end

  def test_read_map
    assert_equal(
      [[0, 1, 2, 3], [1, 2, 3, 4], [8, 7, 6, 5], [9, 8, 7, 6]],
      @hi.read_map(INPUT)
    )
  end

  def test_find_trailheads
    map = @hi.read_map(INPUT)

    assert_equal([[0, 0]], @hi.find_trailheads(map))

    map = @hi.read_map(INPUT2)

    assert_equal(
      [[2, 0], [4, 0], [4, 2], [6, 4], [2, 5], [5, 5], [0, 6], [6, 6], [1, 7]],
      @hi.find_trailheads(map)
    )
  end

  def test_find_trails_for_trailhead
    map = @hi.read_map(INPUT)
    trailheads = @hi.find_trailheads(map)

    assert_equal(1, @hi.find_trails_for_trailhead(map, trailheads[0]))
  end

  def test_find_trails_for_trailhead2
    map = @hi.read_map(INPUT2)
    trailheads = @hi.find_trailheads(map)

    assert_equal(5, @hi.find_trails_for_trailhead(map, trailheads[0]))
    assert_equal(6, @hi.find_trails_for_trailhead(map, trailheads[1]))
    assert_equal(5, @hi.find_trails_for_trailhead(map, trailheads[2]))
    assert_equal(3, @hi.find_trails_for_trailhead(map, trailheads[3]))
    assert_equal(1, @hi.find_trails_for_trailhead(map, trailheads[4]))
    assert_equal(3, @hi.find_trails_for_trailhead(map, trailheads[5]))
    assert_equal(5, @hi.find_trails_for_trailhead(map, trailheads[6]))
    assert_equal(3, @hi.find_trails_for_trailhead(map, trailheads[7]))
    assert_equal(5, @hi.find_trails_for_trailhead(map, trailheads[8]))
  end

  def test_part1
    @hi.setup(INPUT2)

    assert_equal(36, @hi.part1)
  end
end
