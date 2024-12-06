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
      visited, = move(@map, @start)
      @visited = visited.map { |(r, c), _| [r, c] }.uniq

      @visited.size
    end

    def part2
      @visited[1..].count do |row, col|
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
      visited = Set.new

      loop do
        return [visited, true] unless visited.add?([[row, col], direction])
        break if row.zero? || row == height || col.zero? || col == width

        next_row = row + DIRECTIONS[direction][0]
        next_col = col + DIRECTIONS[direction][1]

        if map[next_row][next_col] == '#'
          direction = (direction + 1) % 4
        else
          row = next_row
          col = next_col
        end
      end

      [visited, false]
    end

    def read_map(input)
      map = input.lines(chomp: true).map(&:chars)

      row = map.index { |r| r.include?('^') }
      col = map[row].index('^')

      [map, [row, col]]
    end
  end
end
