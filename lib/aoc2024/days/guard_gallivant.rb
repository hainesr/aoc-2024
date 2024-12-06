# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class GuardGallivant < Day
    DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

    def setup(input = read_input_file.chomp)
      @map, @start = read_map(input)
    end

    def part1
      corners, = move(@map, @start)
      @visited = visited(corners)

      @visited.size
    end

    def part2
      # Don't put a block on the start position.
      (@visited - [@start]).count do |row, col|
        @map[row][col] = '#'

        _, looped = move(@map, @start)

        # Restore the map to its original state.
        @map[row][col] = '.'

        looped
      end
    end

    def move(map, start)
      row, col = start
      direction = 0
      width = map[0].size - 1
      height = map.size - 1
      corners = Set[[[row, col], direction]]

      loop do
        if row.zero? || row == height || col.zero? || col == width
          corners.add([[row, col], direction])
          break
        end

        next_row = row + DIRECTIONS[direction][0]
        next_col = col + DIRECTIONS[direction][1]

        if map[next_row][next_col] == '#'
          direction = (direction + 1) % 4

          # If we've been here before, we're in a loop.
          return [corners, true] unless corners.add?([[row, col], direction])
        else
          row = next_row
          col = next_col
        end
      end

      [corners, false]
    end

    def visited(corners)
      visited = []

      corners.each_cons(2) do |((row1, col1), _), ((row2, col2), _)|
        if row1 == row2
          c1, c2 = [col1, col2].sort
          visited.concat((c1..c2).map { |c| [row1, c] })
        else
          r1, r2 = [row1, row2].sort
          visited.concat((r1..r2).map { |r| [r, col1] })
        end
      end

      visited.uniq
    end

    def read_map(input)
      map = input.lines(chomp: true).map(&:chars)

      row = map.index { |r| r.include?('^') }
      col = map[row].index('^')

      [map, [row, col]]
    end
  end
end
