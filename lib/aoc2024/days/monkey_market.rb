# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class MonkeyMarket < Day
    PRUNE = 0b1000000000000000000000000

    def setup(input = read_input_file.chomp)
      @secrets = input.lines(chomp: true).map(&:to_i)
    end

    def part1
      @secrets.sum do |secret|
        2000.times { secret = next_secret(secret) }
        secret
      end
    end

    def next_secret(s)
      t = ((s << 6) ^ s) % PRUNE
      u = ((t >> 5) ^ t) % PRUNE
      ((u << 11) ^ u) % PRUNE
    end
  end
end
