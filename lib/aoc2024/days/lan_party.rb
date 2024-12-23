# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class LanParty < Day
    def setup(input = read_input_file.chomp)
      @connections = parse_input(input)
    end

    def part1
      threes = Set.new

      @connections.keys.select { |k| k.start_with?('t') }.each do |first|
        @connections[first].to_a.combination(2).each do |a, b|
          threes << [first, a, b].sort if @connections[a].include?(b)
        end
      end

      threes.size
    end

    def part2
      all_groups = Set.new

      @connections.each_key do |first|
        connected = @connections[first].to_a

        (connected.size + 1).downto(1) do |size|
          ([first] + connected).combination(size) do |group|
            all_groups << group.sort if group.all? do |n1|
              group.all? do |n2|
                n1 == n2 || @connections[n1].include?(n2)
              end
            end

            break if all_groups.any? { _1.size == size }
          end
        end
      end

      all_groups.max_by(&:size).join(',')
    end

    def parse_input(input)
      pairs = input.lines(chomp: true).map { |line| line.split('-') }

      pairs.each_with_object({}) do |(a, b), acc|
        (acc[a] ||= Set.new) << b
        (acc[b] ||= Set.new) << a
        acc
      end
    end
  end
end
