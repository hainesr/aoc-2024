# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class CodeChronicle < Day
    def setup(input = read_input_file.chomp)
      @keys, @locks = read_input(input)
    end

    def part1
      @locks.sum do |lock|
        @keys.count do |key|
          lock.zip(key).all? { |l, k| l + k < 6 }
        end
      end
    end

    def read_input(input)
      keys = []
      locks = []

      input.split("\n\n").each do |pattern|
        lines = pattern.lines(chomp: true).map(&:chars)

        columns = lines[0].map.with_index do |_, i|
          lines.count { |line| line[i] == '#' } - 1
        end

        lines[0][0] == '#' ? locks << columns : keys << columns
      end

      [keys, locks]
    end
  end
end
