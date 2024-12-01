# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class HistorianHysteria < Day
    def setup(input = read_input_file.chomp)
      @lists = read_lists(input)
    end

    def part1
      @lists.map(&:sort).transpose.sum { |pair| (pair[0] - pair[1]).abs }
    end

    def part2
      similarities = calculate_similarities(@lists[0], @lists[1])
      @lists[0].sum { |n| similarities[n] }
    end

    def read_lists(input)
      input.lines.map { |l| l.split.map(&:to_i) }.transpose
    end

    def calculate_similarities(list1, list2)
      list1.uniq.to_h { |n| [n, n * list2.count(n)] }
    end
  end
end
