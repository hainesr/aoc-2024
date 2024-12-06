# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/ceres_search'

class AOC2024::CeresSearchTest < Minitest::Test
  INPUT = <<~EOI
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
  EOI

  def setup
    @cs = AOC2024::CeresSearch.new
  end

  def test_read_grid
    grid = @cs.read_grid(INPUT)

    assert_equal(10, grid.size)
    assert_equal(10, grid[0].size)
    assert_equal(%w[M M M S X X M A S M], grid[0])
  end

  def test_part1
    @cs.setup(INPUT)

    assert_equal(18, @cs.part1)
  end

  def test_part2
    @cs.setup(INPUT)

    assert_equal(9, @cs.part2)
  end
end
