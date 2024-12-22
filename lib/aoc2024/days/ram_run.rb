# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'
require_relative '../common/a_star'

module AOC2024
  class RamRun < Day
    def setup(input = read_input_file.chomp)
      @positions = parse_input(input)
      @start = [0, 0]
    end

    def part1(steps: 1024, finish: [70, 70])
      blocks = @positions[0...steps]

      neighbours = lambda { |pos|
        x, y = pos

        [[x, y - 1], [x - 1, y], [x, y + 1], [x + 1, y]].reject do |(a, b)|
          a.negative? || b.negative? || a > finish[0] || b > finish[1] || blocks.include?(pos)
        end
      }

      cost = lambda { |_|
        1
      }

      heuristic = lambda { |pos|
        x, y = pos
        ((finish[0] - x) + (finish[1] - y))
      }

      Common::AStar.solve(@start, finish, neighbours, cost, heuristic)
    end

    def parse_input(input)
      input.lines(chomp: true).map do |line|
        line.split(',').map(&:to_i)
      end
    end
  end
end
