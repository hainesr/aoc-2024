# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class RestroomRedoubt < Day
    def setup(input = read_input_file.chomp)
      @input = read_input(input)
    end

    def part1(max_x: 101, max_y: 103)
      moved = @input.map { |state| move(state, max_x: max_x, max_y: max_y) }
      safety_factor(moved, max_x: max_x, max_y: max_y)
    end

    def safety_factor(positions, max_x: 101, max_y: 103)
      mid_x = (max_x / 2)
      mid_y = (max_y / 2)
      quad_scores = [0, 0, 0, 0]

      positions.each do |(x, y)|
        quad_scores[0] += 1 if x < mid_x && y < mid_y
        quad_scores[1] += 1 if x > mid_x && y < mid_y
        quad_scores[2] += 1 if x < mid_x && y > mid_y
        quad_scores[3] += 1 if x > mid_x && y > mid_y
      end

      quad_scores.reduce(:*)
    end

    def move((pos, vec), secs: 100, max_x: 101, max_y: 103)
      x = pos[0] + (vec[0] * secs)
      y = pos[1] + (vec[1] * secs)

      [x % max_x, y % max_y]
    end

    def read_input(input)
      input.lines(chomp: true).map do |line|
        line.split.map { _1.scan(/-?\d+/).map(&:to_i) }
      end
    end
  end
end
