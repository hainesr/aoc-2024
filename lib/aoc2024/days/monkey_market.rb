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
      secrets = input.lines(chomp: true).map(&:to_i)
      @secret_sum, @changes = build_history(secrets)
    end

    def part1
      @secret_sum
    end

    def part2
      @changes.values.max
    end

    def build_history(input)
      last_secret_sum = 0
      changes_totals = Hash.new(0)

      input.each do |initial|
        secret = initial
        old_price = initial % 10
        changes = {}
        change_sequence = []

        # Calculate the final secret and the price change sequences along the way.
        2000.times do
          secret = next_secret(secret)
          new_price = secret % 10
          price_diff = new_price - old_price
          old_price = new_price
          change_sequence << price_diff

          # Only store a change sequence if we have at least 4 changes.
          next if change_sequence.length < 4

          changes[change_sequence.dup] ||= new_price
          change_sequence.shift
        end

        # Keep a tally of the 2000th secrets.
        last_secret_sum += secret

        # Add the prices for each change sequence to their running totals.
        changes.each do |k, v|
          changes_totals[k] += v
        end
      end

      [last_secret_sum, changes_totals]
    end

    def next_secret(s)
      t = ((s << 6) ^ s) % PRUNE
      u = ((t >> 5) ^ t) % PRUNE
      ((u << 11) ^ u) % PRUNE
    end
  end
end
