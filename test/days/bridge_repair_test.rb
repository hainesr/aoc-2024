# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/bridge_repair'

class AOC2024::BridgeRepairTest < Minitest::Test
  INPUT = <<~EOI
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
  EOI

  def setup
    @br = AOC2024::BridgeRepair.new
  end

  def test_setup
    equations = @br.setup(INPUT)

    assert_equal(9, equations.length)
    assert_equal([190, 10, 19], equations[0])
    assert_equal([3267, 81, 40, 27], equations[1])
    assert_equal([83, 17, 5], equations[2])
    assert_equal([156, 15, 6], equations[3])
    assert_equal([7290, 6, 8, 6, 15], equations[4])
    assert_equal([161_011, 16, 10, 13], equations[5])
    assert_equal([192, 17, 8, 14], equations[6])
    assert_equal([21_037, 9, 7, 18, 13], equations[7])
    assert_equal([292, 11, 6, 16, 20], equations[8])
  end

  def test_possible?
    assert(@br.possible?(190, [19], 10))
    assert(@br.possible?(3267, [40, 27], 81))
  end

  def test_part1
    @br.setup(INPUT)

    assert_equal(3749, @br.part1)
  end
end
