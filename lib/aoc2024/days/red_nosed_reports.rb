# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class RedNosedReports < Day
    def setup(input = read_input_file.chomp)
      @lists = read_lists(input)
    end

    def part1
      @lists.count { |list| report_safe?(list) }
    end

    def read_lists(input)
      input.lines.map { |line| line.split.map(&:to_i) }
    end

    def report_safe?(list)
      sorted = list.sort
      return false unless sorted == list || sorted.reverse == list

      list.each_cons(2).all? do |a, b|
        diff = (a - b).abs
        diff.positive? && diff < 4
      end
    end
  end
end
