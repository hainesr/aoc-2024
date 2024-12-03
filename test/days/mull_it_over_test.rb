# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/mull_it_over'

class AOC2024::MullItOverTest < Minitest::Test
  INPUT = <<~EOI
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    select(){,(where()+-mul(514,727);:]]what():^*from(764,547) mul(550,305)$^^%>
  EOI

  def setup
    @mio = AOC2024::MullItOver.new
  end

  def test_find_muls
    program = @mio.setup(INPUT)

    assert_equal(
      [
        'mul(2,4)', 'mul(5,5)', 'mul(11,8)',
        'mul(8,5)', 'mul(514,727)', 'mul(550,305)'
      ],
      @mio.find_muls(program)
    )
  end

  def test_execute_mul
    assert_equal(8, @mio.execute_mul('mul(2,4)'))
    assert_equal(25, @mio.execute_mul('mul(5,5)'))
    assert_equal(88, @mio.execute_mul('mul(11,8)'))
    assert_equal(40, @mio.execute_mul('mul(8,5)'))
    assert_equal(373_678, @mio.execute_mul('mul(514,727)'))
    assert_equal(167_750, @mio.execute_mul('mul(550,305)'))
  end

  def test_part1
    @mio.setup(INPUT)

    assert_equal(541_589, @mio.part1)
  end
end
