# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2024/days/print_queue'

class AOC2024::PrintQueueTest < Minitest::Test
  INPUT = <<~EOI
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
  EOI

  def setup
    @pq = AOC2024::PrintQueue.new
  end

  def test_read_input
    rules, pages = @pq.read_input(INPUT)

    assert_equal([53, 13, 61, 29], rules[47])
    assert_equal([29, 13], rules[53])
    assert_equal([75, 29, 13], pages[2])
    assert_equal([97, 13, 75, 29, 47], pages[5])
  end

  def test_correct_order?
    rules, pages = @pq.read_input(INPUT)

    assert(@pq.correct_order?(rules, pages[0]))
    assert(@pq.correct_order?(rules, pages[1]))
    assert(@pq.correct_order?(rules, pages[2]))
    refute(@pq.correct_order?(rules, pages[3]))
    refute(@pq.correct_order?(rules, pages[4]))
    refute(@pq.correct_order?(rules, pages[5]))
  end

  def test_part1
    @pq.setup(INPUT)

    assert_equal(143, @pq.part1)
  end
end
