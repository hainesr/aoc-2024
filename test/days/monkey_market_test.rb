# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/monkey_market'

class AOC2024::MonkeyMarketTest < Minitest::Test
  INPUT = <<~EOI
    1
    10
    100
    2024
  EOI

  INPUT2 = <<~EOI
    1
    2
    3
    2024
  EOI

  def setup
    @mm = AOC2024::MonkeyMarket.new
  end

  def test_next_secret
    sequence = [
      15_887_950, 16_495_136, 527_345, 704_524, 1_553_684,
      12_683_156, 11_100_544, 12_249_484, 7_753_432, 5_908_254
    ]

    secret = 123
    sequence.each do |s|
      new_secret = @mm.next_secret(secret)

      assert_equal(s, new_secret)
      secret = new_secret
    end
  end

  def test_part1
    @mm.setup(INPUT)

    assert_equal(37_327_623, @mm.part1)
  end

  def test_part2
    @mm.setup(INPUT2)

    assert_equal(23, @mm.part2)
  end
end
