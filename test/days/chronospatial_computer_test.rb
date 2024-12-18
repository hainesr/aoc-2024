# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/chronospatial_computer'

class AOC2024::ChronospatialComputerTest < Minitest::Test
  INPUT = <<~EOI
    Register A: 729
    Register B: 0
    Register C: 0

    Program: 0,1,5,4,3,0
  EOI

  INPUT2 = <<~EOI
    Register A: 2024
    Register B: 0
    Register C: 0

    Program: 0,3,5,4,3,0
  EOI

  def setup
    @cc = AOC2024::ChronospatialComputer.new
  end

  def test_read_input
    registers, program = @cc.read_input(INPUT)

    assert_equal([729, 0, 0], registers)
    assert_equal([0, 1, 5, 4, 3, 0], program)
  end

  def test_computer_bst
    computer = AOC2024::Computer.new([0, 0, 9], [2, 6])

    assert(computer.step!)
    assert_equal(0, computer.a)
    assert_equal(1, computer.b)
    assert_equal(9, computer.c)
    refute(computer.step!)
  end

  def test_computer_out
    computer = AOC2024::Computer.new([10, 0, 0], [5, 0, 5, 1, 5, 4])

    assert(computer.run!)
    refute(computer.step!)
    assert_equal(10, computer.a)
    assert_equal(0, computer.b)
    assert_equal(0, computer.c)
    assert_equal([0, 1, 2], computer.output)
  end

  def test_computer_bxl
    computer = AOC2024::Computer.new([0, 29, 0], [1, 7])

    assert(computer.step!)
    assert_equal(0, computer.a)
    assert_equal(26, computer.b)
    assert_equal(0, computer.c)
    refute(computer.step!)
  end

  def test_computer_bxc
    computer = AOC2024::Computer.new([0, 2024, 43_690], [4, 0])

    assert(computer.step!)
    assert_equal(0, computer.a)
    assert_equal(44_354, computer.b)
    assert_equal(43_690, computer.c)
    refute(computer.step!)
  end

  def test_computer_run
    computer = AOC2024::Computer.new([2024, 0, 0], [0, 1, 5, 4, 3, 0])

    output = computer.run!

    assert_equal(0, computer.a)
    assert_equal(0, computer.b)
    assert_equal(0, computer.c)
    refute(computer.step!)
    assert_equal([4, 2, 5, 6, 7, 7, 7, 7, 3, 1, 0], output)
  end

  def test_part1
    @cc.setup(INPUT)

    assert_equal('4,6,3,5,6,3,5,2,1,0', @cc.part1)
  end

  def test_part2
    @cc.setup(INPUT2)

    assert_equal(117_440, @cc.part2)
  end
end
