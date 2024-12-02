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

  def test_calculate_diffs
    diffs = @rnr.calculate_diffs(INPUT)

    assert_equal([[7, 6, 4, 2, 1]], diffs[Set[1, 2]])
    assert_equal([[1, 2, 7, 8, 9]], diffs[Set[-1, -5]])
    assert_equal([[1, 3, 6, 7, 9]], diffs[Set[-1, -2, -3]])
  end

  def test_report_safe?
    diffs = @rnr.calculate_diffs(INPUT).keys

    assert(@rnr.report_safe?(diffs[0]))
    refute(@rnr.report_safe?(diffs[1]))
    refute(@rnr.report_safe?(diffs[2]))
    refute(@rnr.report_safe?(diffs[3]))
    refute(@rnr.report_safe?(diffs[4]))
    assert(@rnr.report_safe?(diffs[5]))
  end

  def test_count_safe_dampener
    diffs = @rnr.calculate_diffs(INPUT)

    assert_equal(1, @rnr.count_safe_dampener(diffs.keys[0], diffs.values[0]))
    refute_equal(1, @rnr.count_safe_dampener(diffs.keys[1], diffs.values[1]))
    refute_equal(1, @rnr.count_safe_dampener(diffs.keys[2], diffs.values[2]))
    assert_equal(1, @rnr.count_safe_dampener(diffs.keys[3], diffs.values[3]))
    assert_equal(1, @rnr.count_safe_dampener(diffs.keys[4], diffs.values[4]))
    assert_equal(1, @rnr.count_safe_dampener(diffs.keys[5], diffs.values[5]))
  end

  def test_part1
    @rnr.setup(INPUT)

    assert_equal(2, @rnr.part1)
  end

  def test_part2
    @rnr.setup(INPUT)

    assert_equal(4, @rnr.part2)
  end
end
