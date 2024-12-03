# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  MUL_REGEX = Regexp.new('(mul\(\d{1,3},\d{1,3}\))').freeze
  NUM_REGEX = Regexp.new('\d{1,3}').freeze

  class MullItOver < Day
    def setup(input = read_input_file.chomp)
      @program = input.lines(chomp: true)
    end

    def part1
      find_muls(@program).sum { |mul| execute_mul(mul) }
    end

    def execute_mul(mul)
      mul.scan(NUM_REGEX).map(&:to_i).reduce(:*)
    end

    def find_muls(program)
      program.map { |line| line.scan(MUL_REGEX) }.flatten
    end
  end
end
