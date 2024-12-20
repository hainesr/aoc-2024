# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/linen_layout'

class AOC2024::LinenLayoutTest < Minitest::Test
  INPUT = <<~EOI
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
  EOI

  def setup
    @ll = AOC2024::LinenLayout.new
  end

  def test_read_input
    patterns, designs = @ll.read_input(INPUT)

    assert_equal(%w[r wr b g bwu rb gb br], patterns)
    assert_equal(%w[brwrr bggr gbbr rrbgbr ubwu bwurrg brgr bbrgwb], designs)
  end

  def test_part1
    @ll.setup(INPUT)

    assert_equal(6, @ll.part1)
  end
end
