# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/plutonian_pebbles'

class AOC2024::PlutonianPebblesTest < Minitest::Test
  INPUT = '125 17'

  def setup
    @pp = AOC2024::PlutonianPebbles.new
  end

  def test_setup
    pebbles = @pp.setup(INPUT)

    assert_equal({ 125 => 1, 17 => 1 }, pebbles)
  end

  def test_blink
    pebbles = @pp.setup(INPUT)
    pebbles = @pp.blink(pebbles, 1)

    assert_equal({ 253_000 => 1, 1 => 1, 7 => 1 }, pebbles)
    pebbles = @pp.blink(pebbles, 1)

    assert_equal({ 253 => 1, 0 => 1, 2024 => 1, 14_168 => 1 }, pebbles)
    pebbles = @pp.blink(pebbles, 1)

    assert_equal({ 512_072 => 1, 1 => 1, 20 => 1, 24 => 1, 28_676_032 => 1 }, pebbles)
    pebbles = @pp.blink(pebbles, 1)

    assert_equal(
      { 512 => 1, 72 => 1, 2024 => 1, 2 => 2, 0 => 1, 4 => 1, 2867 => 1, 6032 => 1 },
      pebbles
    )
  end

  def test_part1
    @pp.setup(INPUT)

    assert_equal(55_312, @pp.part1)
  end
end
