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
      move(@map, @start)

      @map.flatten.count('X')
    end

    def move(map, start, direction = 0)
      row, col = start
      width = map[0].size - 1
      height = map.size - 1

      loop do
        map[row][col] = 'X'
        break if row.zero? || row == height || col.zero? || col == width

        next_row = row + DIRECTIONS[direction][0]
        next_col = col + DIRECTIONS[direction][1]

        if map[next_row][next_col] == '#'
          direction = (direction + 1) % 4
          row += DIRECTIONS[direction][0]
          col += DIRECTIONS[direction][1]
        else
          row = next_row
          col = next_col
        end
      end

      [row, col]
    end

    def read_map(input)
      map = input.lines(chomp: true).map(&:chars)

      row = map.index { |r| r.include?('^') }
      col = map[row].index('^')

      [map, [row, col]]
    end
  end
end
