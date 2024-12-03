# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  PRG_REGEX = Regexp.new('(mul\(\d{1,3},\d{1,3}\))|(do\(\))|(don\'t\(\))').freeze
  NUM_REGEX = Regexp.new('\d{1,3}').freeze

  class MullItOver < Day
    def setup(input = read_input_file.chomp)
      @program = parse_program(input.lines(chomp: true))
    end

    def part1
      @program.sum do |instr|
        next 0 unless instr.start_with?('mul')

        execute_mul(instr)
      end
    end

    def part2
      exe = true

      @program.sum do |instr|
        case instr
        when 'do()'
          exe = true
          0
        when "don't()"
          exe = false
          0
        else
          exe ? execute_mul(instr) : 0
        end
      end
    end

    def execute_mul(mul)
      mul.scan(NUM_REGEX).map(&:to_i).reduce(:*)
    end

    def parse_program(program)
      program.map { |line| line.scan(PRG_REGEX) }.flatten.compact
    end
  end
end
