# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/red_nosed_reports'

class AOC2024::RedNosedReportsTest < Minitest::Test
  INPUT = <<~EOI
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
  EOI

  def setup
    @rnr = AOC2024::RedNosedReports.new
  end

  def test_read_lists
    lists = @rnr.read_lists(INPUT)

    assert_equal([7, 6, 4, 2, 1], lists[0])
    assert_equal([1, 2, 7, 8, 9], lists[1])
    assert_equal([1, 3, 6, 7, 9], lists[5])
  end

  def test_report_safe?
    lists = @rnr.read_lists(INPUT)

    assert(@rnr.report_safe?(lists[0]))
    refute(@rnr.report_safe?(lists[1]))
    refute(@rnr.report_safe?(lists[2]))
    refute(@rnr.report_safe?(lists[3]))
    refute(@rnr.report_safe?(lists[4]))
    assert(@rnr.report_safe?(lists[5]))
  end

  def test_part1
    @rnr.setup(INPUT)

    assert_equal(2, @rnr.part1)
  end
end
