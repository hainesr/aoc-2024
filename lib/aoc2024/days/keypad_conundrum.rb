# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class KeypadConundrum < Day
    DIR_MAP = {
      '^' => [0, -1],
      '>' => [1, 0],
      'v' => [0, 1],
      '<' => [-1, 0]
    }.freeze

    KEYPAD = {
      '7' => [0, 0], '8' => [1, 0], '9' => [2, 0],
      '4' => [0, 1], '5' => [1, 1], '6' => [2, 1],
      '1' => [0, 2], '2' => [1, 2], '3' => [2, 2],
                     '0' => [1, 3], 'A' => [2, 3] # rubocop:disable Layout/HashAlignment
    }.freeze

    KEYPAD_START = KEYPAD['A']
    KEYPAD_DEADSPOT = [0, 3].freeze

    DPAD = {
                     '^' => [1, 0], 'A' => [2, 0], # rubocop:disable Layout/FirstHashElementIndentation
      '<' => [0, 1], 'v' => [1, 1], '>' => [2, 1]  # rubocop:disable Layout/HashAlignment
    }.freeze

    DPAD_START = DPAD['A']
    DPAD_DEADSPOT = [0, 0].freeze

    def setup(input = read_input_file.chomp)
      # Cache the moves and minimum number of moves at each stage.
      @moves_cache = {}
      @min_moves_cache = {}

      @codes = input.lines(chomp: true)
    end

    def part1
      @codes.sum { |code| min_moves_for_code(code) * code.to_i }
    end

    def moves_to_position(start, finish, deadspot)
      return ['A'] if start == finish

      fingerprint = [start, finish, deadspot] # Use deadspot as a keypad marker.
      return @moves_cache[fingerprint] if @moves_cache.key?(fingerprint)

      delta_x = keypad_x(finish[0] - start[0])
      delta_y = keypad_y(finish[1] - start[1])

      # Pretty sure we only care about two sides of a rectangle here...
      # Only store valid paths, but we do need to keep both (if valid) as
      # we don't know which will be optimal for the keypad chain.
      @moves_cache[fingerprint] = [delta_x + delta_y, delta_y + delta_x].filter_map do |moves|
        "#{moves}A" if valid_moves?(moves, start, deadspot)
      end.uniq
    end

    def min_moves_for_code(code, depth = 2, keypad = KEYPAD, deadspot = KEYPAD_DEADSPOT)
      fingerprint = [code, depth]
      return @min_moves_cache[fingerprint] if @min_moves_cache.key?(fingerprint)

      current_pos = keypad['A']
      count = 0
      code.each_char do |c|
        next_pos = keypad[c]
        moves = moves_to_position(current_pos, next_pos, deadspot)
        count += if depth.positive?
                   moves.map { min_moves_for_code(_1, depth - 1, DPAD, DPAD_DEADSPOT) }.min
                 else
                   moves[0].size
                 end

        current_pos = next_pos
      end

      @min_moves_cache[fingerprint] = count
    end

    def keypad_x(delta)
      delta.negative? ? '<' * -delta : '>' * delta
    end

    def keypad_y(delta)
      delta.negative? ? '^' * -delta : 'v' * delta
    end

    def valid_moves?(moves, start, deadspot)
      current = start.dup
      moves.each_char do |move|
        return false if current == deadspot

        current[0] += DIR_MAP[move][0]
        current[1] += DIR_MAP[move][1]
      end

      true
    end
  end
end
