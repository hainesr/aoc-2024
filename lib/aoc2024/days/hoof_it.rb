# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class HoofIt < Day
    MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

    def setup(input = read_input_file.chomp)
      @map = read_map(input)
      @trailheads = find_trailheads(@map)
    end

    def part1
      @trailheads.sum do |trailhead|
        find_trails_for_trailhead(@map, trailhead)
      end
    end

    def part2
      @trailheads.sum do |trailhead|
        find_trails_for_trailhead(@map, trailhead, unique: true)
      end
    end

    def find_trails_for_trailhead(map, trailhead, unique: false)
      trails = 0
      visited = Set.new
      paths = [trailhead]

      x_range = (0...map[0].size)
      y_range = (0...map.size)

      while paths.any?
        coord = paths.shift
        x, y = coord
        next if visited.include?(coord) && !unique

        visited << coord
        height = map[y][x]

        if height == 9
          trails += 1
          next
        end

        MOVES.each do |dx, dy|
          nx = x + dx
          ny = y + dy
          paths << [nx, ny] if x_range.include?(nx) && y_range.include?(ny) && map[ny][nx] == height + 1
        end
      end

      trails
    end

    def read_map(input)
      input.lines(chomp: true).map { |line| line.chars.map(&:to_i) }
    end

    def find_trailheads(map)
      trailheads = []

      map.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          trailheads << [x, y] if cell.zero?
        end
      end

      trailheads
    end
  end
end
