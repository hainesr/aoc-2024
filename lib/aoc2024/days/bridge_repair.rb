# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class BridgeRepair < Day
    OPS = [:+, :*].freeze

    def setup(input = read_input_file.chomp)
      # [answer, value 1, value 2, ...]
      @equations = input.lines(chomp: true).map do |line|
        line.scan(/\d+/).map(&:to_i)
      end
    end

    def part1
      @equations.sum do |eq|
        answer, *tail = eq
        head = tail.shift
        possible?(answer, tail, head) ? answer : 0
      end
    end

    def possible?(answer, tail, head)
      return OPS.any? { |op| answer == head.send(op, tail[0]) } if tail.size == 1

      OPS.any? do |op|
        possible?(answer, tail[1..], head.send(op, tail[0]))
      end
    end
  end
end
