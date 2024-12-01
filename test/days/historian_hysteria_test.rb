# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/historian_hysteria'

class AOC2024::HistorianHysteriaTest < Minitest::Test
  INPUT = <<~EOI
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
  EOI

  def setup
    @hh = AOC2024::HistorianHysteria.new
  end

  def test_read_lists
    list1, list2 = @hh.read_lists(INPUT)

    assert_equal([3, 4, 2, 1, 3, 3], list1)
    assert_equal([4, 3, 5, 3, 9, 3], list2)
  end

  def test_part1
    @hh.setup(INPUT)

    assert_equal(11, @hh.part1)
  end
end
