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
      @antennae.reduce(Set.new) do |acc, antennae|
        acc + find_antinodes(antennae, @side_length)
      end.size
    end

    def part2
      @antennae.reduce(Set.new) do |acc, antennae|
        acc + antennae + find_antinodes(antennae, @side_length, repeat: true)
      end.size
    end

    def find_antinodes(antennae, bounds, repeat: false) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      antinodes = Set.new

      antennae.combination(2) do |((x1, y1), (x2, y2))|
        diff_x = x2 - x1
        diff_y = y2 - y1

        i = 1
        loop do
          nx = x1 - (diff_x * i)
          ny = y1 - (diff_y * i)
          break if nx.negative? || ny.negative? || nx >= bounds || ny >= bounds

          antinodes << [nx, ny]
          break unless repeat

          i += 1
        end

        j = 1
        loop do
          nx = x2 + (diff_x * j)
          ny = y2 + (diff_y * j)
          break if nx.negative? || ny.negative? || nx >= bounds || ny >= bounds

          antinodes << [nx, ny]
          break unless repeat

          j += 1
        end
      end

      antinodes
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

      [side_length, antennae.values]
    end
  end
end
