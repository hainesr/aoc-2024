# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class ClawContraption < Day
    def setup(input = read_input_file.chomp)
      @games = read_input(input)
    end

    def part1
      @games.sum { |game| game_cost(game) }.to_i
    end

    def game_cost(game)
      (ax, ay), (bx, by), (px, py) = game

      # I'll admit I had to look how to do this bit up...
      div = ((ax * by) - (ay * bx))
      a = ((px * by) - (py * bx)) / div
      b = ((py * ax) - (px * ay)) / div

      # If we have two integers here, then we have a valid solution.
      a % 1 != 0 || b % 1 != 0 ? 0 : (a * 3) + b
    end

    def read_input(input)
      input.split("\n\n").map do |game|
        game.split("\n").map do |line|
          line.scan(/\d+/).map(&:to_f)
        end
      end
    end
  end
end
