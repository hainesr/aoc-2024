# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class CrossedWires < Day
    def setup(input = read_input_file.chomp)
      # Need to store initial x and y values globally so we can access them
      # at runtime from the all the lambda functions.
      @x = []
      @y = []

      @states, @gates = read_input(input)
    end

    def part1
      @gates.each do |str|
        a1, op, a2, out = str.scan(/[A-Za-z0-9]+/)
        @states[out] = build_op(a1, op, a2)
      end

      # This calls all the lambdas as they are needed to calculate the final
      # result. Asking for the value of the 'z' states will trigger all the
      # calculations required.
      @states.keys.select { |k| k.start_with?('z') }.sort.map { |k| @states[k].call }.reverse.join.to_i(2)
    end

    def build_op(arg1, operation, arg2)
      # Build all the operations as lambdas so we can run them later.
      case operation
      when 'AND'
        -> { @states[arg1].call & @states[arg2].call }
      when 'OR'
        -> { @states[arg1].call | @states[arg2].call }
      when 'XOR'
        -> { @states[arg1].call ^ @states[arg2].call }
      end
    end

    def read_input(input)
      states_str, gates_str = input.split("\n\n")

      states = states_str.lines(chomp: true).to_h do |line|
        name, value = line.split(': ')
        label = name[0]
        index = name[1..].to_i

        array = label == 'x' ? @x : @y
        array[index] = value.to_i

        # Build all the states as lambdas so we can run them later.
        [name, -> { array[index] }]
      end

      [states, gates_str.lines(chomp: true)]
    end
  end
end
