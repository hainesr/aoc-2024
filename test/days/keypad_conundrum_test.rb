# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/keypad_conundrum'

class AOC2024::KeypadConundrumTest < Minitest::Test
  INPUT = <<~EOI
    029A
    980A
    179A
    456A
    379A
  EOI

  def setup
    @kc = AOC2024::KeypadConundrum.new
  end

  def test_setup
    codes = @kc.setup(INPUT)

    assert_equal('029A', codes[0])
    assert_equal('980A', codes[1])
    assert_equal('179A', codes[2])
    assert_equal('456A', codes[3])
    assert_equal('379A', codes[4])
  end

  def test_keypad_x
    assert_equal('', @kc.keypad_x(0))
    assert_equal('>', @kc.keypad_x(1))
    assert_equal('>>', @kc.keypad_x(2))
    assert_equal('<', @kc.keypad_x(-1))
    assert_equal('<<', @kc.keypad_x(-2))
  end

  def test_keypad_y
    assert_equal('', @kc.keypad_y(0))
    assert_equal('v', @kc.keypad_y(1))
    assert_equal('vv', @kc.keypad_y(2))
    assert_equal('^', @kc.keypad_y(-1))
    assert_equal('^^', @kc.keypad_y(-2))
  end

  def test_valid_moves?
    ka = AOC2024::KeypadConundrum::KEYPAD['A']

    assert(@kc.valid_moves?('', ka, [0, 3]))
    assert(@kc.valid_moves?('^^^<<', ka, [0, 3]))
    refute(@kc.valid_moves?('<<^^^', ka, [0, 3]))
  end

  def test_moves_to_position
    @kc.setup(INPUT)
    ka = AOC2024::KeypadConundrum::KEYPAD['A']
    k7 = AOC2024::KeypadConundrum::KEYPAD['7']
    da = AOC2024::KeypadConundrum::DPAD['A']
    dup = AOC2024::KeypadConundrum::DPAD['^']

    assert_equal(['A'], @kc.moves_to_position(ka, ka, [0, 3]))
    assert_equal(['^^^<<A'], @kc.moves_to_position(ka, k7, [0, 3]))
    assert_equal(['<A'], @kc.moves_to_position(da, dup, [0, 0]))
  end

  def test_min_moves_for_code
    @kc.setup(INPUT)

    assert_equal(12, @kc.min_moves_for_code('029A', 0))
    assert_equal(28, @kc.min_moves_for_code('029A', 1))
    assert_equal(68, @kc.min_moves_for_code('029A'))
  end

  def test_part1
    @kc.setup(INPUT)

    assert_equal(126_384, @kc.part1)
  end
end
