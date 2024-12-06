# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class CeresSearch < Day
    PATTERNS = [
      # Horizontal.
      [[[0, 0], 'X'], [[0, 1], 'M'], [[0, 2], 'A'], [[0, 3], 'S']].freeze,
      [[[0, 0], 'S'], [[0, 1], 'A'], [[0, 2], 'M'], [[0, 3], 'X']].freeze,

      # Vertical.
      [[[0, 0], 'X'], [[1, 0], 'M'], [[2, 0], 'A'], [[3, 0], 'S']].freeze,
      [[[0, 0], 'S'], [[1, 0], 'A'], [[2, 0], 'M'], [[3, 0], 'X']].freeze,

      # Diagonal down.
      [[[0, 0], 'X'], [[1, 1], 'M'], [[2, 2], 'A'], [[3, 3], 'S']].freeze,
      [[[0, 0], 'S'], [[1, 1], 'A'], [[2, 2], 'M'], [[3, 3], 'X']].freeze,

      # Diagonal up.
      [[[0, 0], 'X'], [[1, -1], 'M'], [[2, -2], 'A'], [[3, -3], 'S']].freeze,
      [[[0, 0], 'S'], [[1, -1], 'A'], [[2, -2], 'M'], [[3, -3], 'X']].freeze
    ].freeze

    def setup(input = read_input_file.chomp)
      @grid = input.lines(chomp: true).map(&:chars)
    end

    def part1
      count = 0
      width = @grid[0].size
      height = @grid.size

      (0...height).each do |row|
        (0...width).each do |col|
          count += PATTERNS.count do |pattern|
            pattern.all? do |(dx, dy), c|
              x = col + dx
              y = row + dy
              next false if x.negative? || x >= width || y.negative? || y >= height

              @grid[y][x] == c
            end
          end
        end
      end

      count
    end
  end
end
