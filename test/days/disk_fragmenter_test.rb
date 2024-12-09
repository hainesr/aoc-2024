# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/disk_fragmenter'

class AOC2024::DiskFragmenterTest < Minitest::Test
  INPUT1 = '12345'
  INPUT2 = '2333133121414131402'

  def setup
    @df = AOC2024::DiskFragmenter.new
  end

  def test_read_disk_map
    blocks, free = @df.read_disk_map(INPUT1)

    assert_equal([1, 3, 5], blocks)
    assert_equal([2, 4], free)

    blocks, free = @df.read_disk_map(INPUT2)

    assert_equal([2, 3, 1, 3, 2, 4, 4, 3, 4, 2], blocks)
    assert_equal([3, 3, 3, 1, 1, 1, 1, 1, 0], free)
  end

  def test_part1
    @df.setup(INPUT1)

    assert_equal(60, @df.part1)

    @df.setup(INPUT2)

    assert_equal(1928, @df.part1)
  end
end
