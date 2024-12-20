# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class LinenLayout < Day
    def setup(input = read_input_file.chomp)
      @patterns, @designs = read_input(input)

      # Need a global cache as some designs will be subsets of others so
      # we can avoid recalculating those bits of larger designs.
      @counts = {}
    end

    def part1
      @designs.count { |d| count(d).positive? }
    end

    def part2
      @designs.sum { |d| count(d) }
    end

    def count(design)
      return 1 if design.empty?

      # Return the count for this design (or part of a design) if we have
      # already calculated it. If not, calculate it now by recursion.
      @counts[design] ||= @patterns.select { |d| design.start_with?(d) }.sum do |d|
        count(design[d.size..])
      end
    end

    def read_input(input)
      patterns, designs = input.split("\n\n").map(&:chomp)

      [patterns.split(', '), designs.lines(chomp: true)]
    end
  end
end
