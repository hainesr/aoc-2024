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
      # Part 1.
      [
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
      ].freeze,

      # Part 2.
      [
        # MAS, MAS.
        [
          [[0, 0], 'M'], [[2, 0], 'M'],
          [[1, 1], 'A'],
          [[0, 2], 'S'], [[2, 2], 'S']
        ].freeze,

        # SAM, SAM.
        [
          [[0, 0], 'S'], [[2, 0], 'S'],
          [[1, 1], 'A'],
          [[0, 2], 'M'], [[2, 2], 'M']
        ].freeze,

        # MAS, SAM.
        [
          [[0, 0], 'M'], [[2, 0], 'S'],
          [[1, 1], 'A'],
          [[0, 2], 'M'], [[2, 2], 'S']
        ].freeze,

        # SAM, MAS.
        [
          [[0, 0], 'S'], [[2, 0], 'M'],
          [[1, 1], 'A'],
          [[0, 2], 'S'], [[2, 2], 'M']
        ].freeze
      ].freeze
    ].freeze

    def setup(input = read_input_file.chomp)
      @counts = count_patterns(read_grid(input))
    end

    def part1
      @counts[0]
    end

    def part2
      @counts[1]
    end

    def count_patterns(grid)
      counts = [0, 0]
      width = grid[0].size
      height = grid.size

      (0...height).each do |row|
        (0...width).each do |col|
          2.times do |part|
            counts[part] += PATTERNS[part].count do |pattern|
              pattern.all? do |(dx, dy), c|
                x = col + dx
                y = row + dy
                next false if x.negative? || x >= width || y.negative? || y >= height

                grid[y][x] == c
              end
            end
          end
        end
      end

      counts
    end

    def read_grid(input)
      input.lines(chomp: true).map(&:chars)
    end
  end
end
