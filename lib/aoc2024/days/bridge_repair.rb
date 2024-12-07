# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

# Ruby you beauty!
class Integer
  def cat(other)
    "#{self}#{other}".to_i
  end
end

module AOC2024
  class BridgeRepair < Day
    OPS = [:+, :*].freeze
    OPS_2 = [:+, :*, :cat].freeze

    def setup(input = read_input_file.chomp)
      # [answer, value 1, value 2, ...]
      @equations = input.lines(chomp: true).map do |line|
        line.scan(/\d+/).map(&:to_i)
      end
    end

    def part1
      part1, @part2 = @equations.partition do |eq|
        answer, *tail = eq
        head = tail.shift
        possible?(answer, tail, head)
      end

      @part1 = part1.sum { |eq| eq[0] }
    end

    def part2
      @part2.sum do |eq|
        answer, *tail = eq
        head = tail.shift
        possible?(answer, tail, head, OPS_2) ? answer : 0
      end + @part1
    end

    def possible?(answer, tail, head, ops = OPS)
      return false if head > answer
      return ops.any? { |op| answer == head.send(op, tail[0]) } if tail.size == 1

      ops.any? do |op|
        possible?(answer, tail[1..], head.send(op, tail[0]), ops)
      end
    end
  end
end
