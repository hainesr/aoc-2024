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

  def test_count
    @ll.setup(INPUT)

    assert_equal(2, @ll.count('brwrr'))
    assert_equal(1, @ll.count('bggr'))
    assert_equal(4, @ll.count('gbbr'))
    assert_equal(6, @ll.count('rrbgbr'))
    assert_equal(0, @ll.count('ubwu'))
    assert_equal(1, @ll.count('bwurrg'))
    assert_equal(2, @ll.count('brgr'))
    assert_equal(0, @ll.count('bbrgwb'))
  end

  def test_part1
    @ll.setup(INPUT)

    assert_equal(6, @ll.part1)
  end

  def test_part2
    @ll.setup(INPUT)

    assert_equal(16, @ll.part2)
  end
end
