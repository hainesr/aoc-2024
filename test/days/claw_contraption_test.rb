# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/claw_contraption'

class AOC2024::ClawContraptionTest < Minitest::Test
  INPUT = <<~EOI
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400

    Button A: X+26, Y+66
    Button B: X+67, Y+21
    Prize: X=12748, Y=12176

    Button A: X+17, Y+86
    Button B: X+84, Y+37
    Prize: X=7870, Y=6450

    Button A: X+69, Y+23
    Button B: X+27, Y+71
    Prize: X=18641, Y=10279
  EOI

  def setup
    @cc = AOC2024::ClawContraption.new
  end

  def test_read_input
    games = @cc.read_input(INPUT)

    assert_equal(4, games.size)
    assert_equal([[94, 34], [22, 67], [8400, 5400]], games[0])
    assert_equal([[26, 66], [67, 21], [12_748, 12_176]], games[1])
    assert_equal([[17, 86], [84, 37], [7870, 6450]], games[2])
    assert_equal([[69, 23], [27, 71], [18_641, 10_279]], games[3])
  end

  def test_game_cost
    games = @cc.read_input(INPUT)

    assert_equal(280, @cc.game_cost(games[0]))
    assert_equal(0, @cc.game_cost(games[1]))
    assert_equal(200, @cc.game_cost(games[2]))
    assert_equal(0, @cc.game_cost(games[3]))
  end

  def test_game_cost_part2
    games = @cc.read_input(INPUT)

    assert_equal(0, @cc.game_cost(games[0], 10_000_000_000_000))
    assert_equal(459_236_326_669, @cc.game_cost(games[1], 10_000_000_000_000))
    assert_equal(0, @cc.game_cost(games[2], 10_000_000_000_000))
    assert_equal(416_082_282_239, @cc.game_cost(games[3], 10_000_000_000_000))
  end

  def test_part1
    @cc.setup(INPUT)

    assert_equal(480, @cc.part1)
  end

  def test_part2
    @cc.setup(INPUT)

    assert_equal(875_318_608_908, @cc.part2)
  end
end
