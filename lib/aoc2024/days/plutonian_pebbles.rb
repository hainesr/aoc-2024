# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class PlutonianPebbles < Day
    def setup(input = read_input_file.chomp)
      @pebbles = input.split.map(&:to_i).tally
    end

    def part1
      blink(@pebbles, 25).values.sum
    end

    def blink(pebbles, blinks)
      blinks.times do
        new_pebbles = Hash.new(0)

        pebbles.each do |pebble, count|
          if pebble.zero?
            new_pebbles[1] += count
          else
            # #digits returns the digits units-first, so we need to reverse.
            digits = pebble.digits.reverse

            if digits.length.even?
              half = digits.length / 2
              left = digits[..(half - 1)].join.to_i
              right = digits[half..].join.to_i

              new_pebbles[left] += count
              new_pebbles[right] += count
            else
              new_pebbles[pebble * 2024] += count
            end
          end
        end

        pebbles = new_pebbles
      end

      pebbles
    end
  end
end
