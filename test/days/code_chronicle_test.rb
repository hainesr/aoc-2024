# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/code_chronicle'

class AOC2024::CodeChronicleTest < Minitest::Test
  INPUT = <<~EOI
    #####
    .####
    .####
    .####
    .#.#.
    .#...
    .....

    #####
    ##.##
    .#.##
    ...##
    ...#.
    ...#.
    .....

    .....
    #....
    #....
    #...#
    #.#.#
    #.###
    #####

    .....
    .....
    #.#..
    ###..
    ###.#
    ###.#
    #####

    .....
    .....
    .....
    #....
    #.#..
    #.#.#
    #####
  EOI

  def setup
    @cc = AOC2024::CodeChronicle.new
  end

  def test_read_input
    keys, locks = @cc.read_input(INPUT)

    assert_equal(3, keys.length)
    assert_equal(2, locks.length)
    assert_equal([5, 0, 2, 1, 3], keys[0])
    assert_equal([4, 3, 4, 0, 2], keys[1])
    assert_equal([3, 0, 2, 0, 1], keys[2])
    assert_equal([0, 5, 3, 4, 3], locks[0])
    assert_equal([1, 2, 0, 5, 3], locks[1])
  end

  def test_part1
    @cc.setup(INPUT)

    assert_equal(3, @cc.part1)
  end
end
