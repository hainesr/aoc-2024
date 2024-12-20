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
    end

    def part1
      regex = Regexp.new("^(#{@patterns.join('|')})+$")
      @designs.count { |d| regex.match?(d) }
    end

    def read_input(input)
      patterns, designs = input.split("\n\n").map(&:chomp)

      [patterns.split(', '), designs.lines(chomp: true)]
    end
  end
end
