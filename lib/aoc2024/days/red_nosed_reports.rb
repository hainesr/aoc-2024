# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class RedNosedReports < Day
    SAFE_INCR = Set[1, 2, 3].freeze
    SAFE_DECR = Set[-1, -2, -3].freeze

    def setup(input = read_input_file.chomp)
      @cache = calculate_diffs(input)
    end

    def part1
      @cache.sum { |set, lists| report_safe?(set) ? lists.size : 0 }
    end

    def read_lists(input)
      input.lines.map { |line| line.split.map(&:to_i) }
    end

    def calculate_diffs(input)
      cache = Hash.new { |h, k| h[k] = [] }

      read_lists(input).each do |list|
        set = list.each_cons(2).to_set { |a, b| a - b }
        cache[set] << list
      end

      cache
    end

    def report_safe?(diffs)
      diffs.subset?(SAFE_INCR) || diffs.subset?(SAFE_DECR)
    end
  end
end
