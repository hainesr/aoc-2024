# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class RaceCondition < Day
    DIRECTIONS = [
      [-1, 0], # left
      [1, 0],  # right
      [0, -1], # up
      [0, 1]   # down
    ].freeze

    def setup(input = read_input_file.chomp)
      @map, @start, finish = read_map(input)
      @start_dists = calc_distances(@start)
      @finish_dists = calc_distances(finish)
    end

    def part1(threshold: 100)
      find_cheats(2, threshold: threshold)
    end

    def part2(threshold: 100)
      find_cheats(20, threshold: threshold)
    end

    def find_cheats(max_cheat = 2, threshold: 100) # rubocop:disable Metrics/AbcSize
      cheats = Hash.new(0)

      @start_dists.each do |pos, dist|
        # For each position, look at all the possible cheat positions.
        ((pos[0] - max_cheat)..(pos[0] + max_cheat)).each do |x|
          # Due to Manhattan distance, we can limit the range of y values
          # based on the x value.
          dy = max_cheat - (pos[0] - x).abs

          ((pos[1] - dy)..(pos[1] + dy)).each do |y|
            test_pos = [x, y]
            next unless @finish_dists.key?(test_pos)

            # Manhatten distance of the cheat.
            cheat_dist = (pos[0] - x).abs + (pos[1] - y).abs

            # Cost and benefit of the cheat.
            cost = dist + @finish_dists[test_pos] + cheat_dist
            benefit = @finish_dists[@start] - cost

            cheats[[pos, test_pos]] = benefit if benefit >= threshold
          end
        end
      end

      cheats.size
    end

    def calc_distances(start)
      distances = Hash.new(Float::INFINITY)
      positions = [[start, 0]]

      while positions.any?
        pos, dist = positions.shift
        next if distances[pos] < dist

        distances[pos] = dist
        DIRECTIONS.each do |d|
          new_x = pos[0] + d[0]
          new_y = pos[1] + d[1]
          positions << [[new_x, new_y], dist + 1] unless @map[new_y][new_x] == '#'
        end
      end

      distances
    end

    def read_map(input)
      map = input.lines(chomp: true).map(&:chars)

      start = nil
      finish = nil

      map.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          start = [x, y] if cell == 'S'
          finish = [x, y] if cell == 'E'
        end
      end

      [map, start, finish]
    end
  end
end
