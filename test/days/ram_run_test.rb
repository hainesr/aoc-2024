# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/ram_run'

class AOC2024::RamRunTest < Minitest::Test
  INPUT = <<~EOI
    5,4
    4,2
    4,5
    3,0
    2,1
    6,3
    2,4
    1,5
    0,6
    3,3
    2,6
    5,1
    1,2
    5,5
    2,5
    6,5
    1,4
    0,4
    6,4
    1,1
    6,1
    1,0
    0,5
    1,6
    2,0
  EOI

  def setup
    @rr = AOC2024::RamRun.new
  end

  def test_parse_input
    positions = @rr.parse_input(INPUT)

    assert_equal(25, positions.length)
    assert_equal([5, 4], positions[0])
    assert_equal([2, 0], positions[24])
  end

  def test_part1
    @rr.setup(INPUT)

    assert_equal(22, @rr.part1(steps: 12, finish: [6, 6]))
  end
end
