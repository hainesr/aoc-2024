# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/restroom_redoubt'

class AOC2024::RestroomRedoubtTest < Minitest::Test
  INPUT = <<~EOI
    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3
  EOI

  def setup
    @rr = AOC2024::RestroomRedoubt.new
  end

  def test_read_input
    input = @rr.read_input(INPUT)

    assert_equal(12, input.length)
    assert_equal([[0, 4], [3, -3]], input[0])
    assert_equal([[9, 5], [-3, -3]], input[11])
  end

  def test_move # rubocop:disable Minitest/MultipleAssertions
    input = @rr.read_input(INPUT)

    assert_equal([3, 1], @rr.move(input[0], secs: 1, max_x: 11, max_y: 7))
    assert_equal([5, 0], @rr.move(input[1], secs: 1, max_x: 11, max_y: 7))
    assert_equal([9, 5], @rr.move(input[2], secs: 1, max_x: 11, max_y: 7))
    assert_equal([4, 6], @rr.move(input[3], secs: 1, max_x: 11, max_y: 7))
    assert_equal([1, 3], @rr.move(input[4], secs: 1, max_x: 11, max_y: 7))
    assert_equal([1, 5], @rr.move(input[5], secs: 1, max_x: 11, max_y: 7))
    assert_equal([6, 3], @rr.move(input[6], secs: 1, max_x: 11, max_y: 7))
    assert_equal([2, 5], @rr.move(input[7], secs: 1, max_x: 11, max_y: 7))
    assert_equal([0, 6], @rr.move(input[8], secs: 1, max_x: 11, max_y: 7))
    assert_equal([6, 5], @rr.move(input[9], secs: 1, max_x: 11, max_y: 7))
    assert_equal([4, 1], @rr.move(input[10], secs: 1, max_x: 11, max_y: 7))
    assert_equal([6, 2], @rr.move(input[11], secs: 1, max_x: 11, max_y: 7))
  end

  def test_move100 # rubocop:disable Minitest/MultipleAssertions
    input = @rr.read_input(INPUT)

    assert_equal([3, 5], @rr.move(input[0], max_x: 11, max_y: 7))
    assert_equal([5, 4], @rr.move(input[1], max_x: 11, max_y: 7))
    assert_equal([9, 0], @rr.move(input[2], max_x: 11, max_y: 7))
    assert_equal([4, 5], @rr.move(input[3], max_x: 11, max_y: 7))
    assert_equal([1, 6], @rr.move(input[4], max_x: 11, max_y: 7))
    assert_equal([1, 3], @rr.move(input[5], max_x: 11, max_y: 7))
    assert_equal([6, 0], @rr.move(input[6], max_x: 11, max_y: 7))
    assert_equal([2, 3], @rr.move(input[7], max_x: 11, max_y: 7))
    assert_equal([0, 2], @rr.move(input[8], max_x: 11, max_y: 7))
    assert_equal([6, 0], @rr.move(input[9], max_x: 11, max_y: 7))
    assert_equal([4, 5], @rr.move(input[10], max_x: 11, max_y: 7))
    assert_equal([6, 6], @rr.move(input[11], max_x: 11, max_y: 7))
  end

  def test_part1
    @rr.setup(INPUT)

    assert_equal(12, @rr.part1(max_x: 11, max_y: 7))
  end
end
