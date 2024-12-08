# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class ResonantCollinearity < Day
    def setup(input = read_input_file.chomp)
      @side_length, @antennae = read_input(input)
    end

    def part1
      find_antinodes(@antennae).size
    end

    def find_antinodes(antennae, bounds = @side_length)
      antinodes = Set.new

      antennae.each_value do |list|
        antinodes += list.combination(2).flat_map do |((x1, y1), (x2, y2))|
          diff_x = x2 - x1
          diff_y = y2 - y1

          [[x1 - diff_x, y1 - diff_y], [x2 + diff_x, y2 + diff_y]]
        end
      end

      antinodes.select { |x, y| x >= 0 && y >= 0 && x < bounds && y < bounds }
    end

    def read_input(input)
      side_length = 0
      antennae = Hash.new { |h, k| h[k] = [] }

      input.lines(chomp: true).each_with_index do |line, y|
        side_length = line.length if y.zero?

        line.chomp.each_char.with_index do |char, x|
          next if char == '.'

          antennae[char] << [y, x]
        end
      end

      [side_length, antennae]
    end
  end
end
