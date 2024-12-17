# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class ChronospatialComputer < Day
    def setup(input = read_input_file.chomp)
      registers, program = read_input(input)
      @computer = Computer.new(registers, program)
    end

    def part1
      @computer.run!.join(',')
    end

    def read_input(input)
      registers, program = input.split("\n\n")

      registers = registers.lines(chomp: true).map do |line|
        line.split(': ')[1].to_i
      end

      [registers, program.split(': ')[1].split(',').map(&:to_i)]
    end
  end

  class Computer
    attr_reader :a, :b, :c, :output

    def initialize(registers, program)
      @a, @b, @c = registers
      @program = program
      @pc = 0
      @output = []
      @instructions = instructions
    end

    def run!
      loop do
        break unless step!
      end

      @output
    end

    def step!
      return false if @pc >= @program.length

      instr = @program[@pc]
      op = @program[@pc + 1]
      @instructions[instr].call(op)

      true
    end

    private

    def combo_op(num)
      case num
      when 0, 1, 2, 3
        num
      when 4
        @a
      when 5
        @b
      when 6
        @c
      end
    end

    def instructions # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      {
        # adv
        0 => lambda { |op|
          @a /= (2**combo_op(op))
          @pc += 2
        },

        # bxl
        1 => lambda { |op|
          @b ^= op
          @pc += 2
        },

        # bst
        2 => lambda { |op|
          @b = combo_op(op) % 8
          @pc += 2
        },

        # jnz
        3 => lambda { |op|
          if @a.zero?
            @pc += 2
          else
            @pc = combo_op(op)
          end
        },

        # bxc
        4 => lambda { |_op|
          @b ^= @c
          @pc += 2
        },

        # out
        5 => lambda { |op|
          @output << (combo_op(op) % 8)
          @pc += 2
        },

        # bdv
        6 => lambda { |op|
          @b = @a / (2**combo_op(op))
          @pc += 2
        },

        # cdv
        7 => lambda { |op|
          @c = @a / (2**combo_op(op))
          @pc += 2
        }
      }.freeze
    end
  end
end
