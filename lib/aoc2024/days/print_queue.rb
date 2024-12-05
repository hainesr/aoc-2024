# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class PrintQueue < Day
    def setup(input = read_input_file.chomp)
      @rules, pages = read_input(input)
      @correct, @incorrect = pages.partition do |p|
        correct_order?(@rules, p)
      end
    end

    def part1
      @correct.sum { |pages| pages[pages.size / 2] }
    end

    def part2
      sorted = @incorrect.map do |pages|
        pages.sort do |a, b|
          if @rules[a].include?(b)
            -1
          else
            @rules[b].include?(a) ? 1 : 0
          end
        end
      end

      sorted.sum { |pages| pages[pages.size / 2] }
    end

    def correct_order?(rules, pages)
      pages = pages.reverse
      pages.each_with_index do |page, i|
        return false if rules[page].any? { |p| pages[(i + 1)..].include?(p) }
      end

      true
    end

    def read_input(input)
      rules, pages = input.split("\n\n").map { |section| section.split("\n") }

      ordering = Hash.new { |h, k| h[k] = [] }
      rules.map { |line| line.split('|').map(&:to_i) }.each do |a, b|
        ordering[a] << b
      end

      [
        ordering,
        (pages.map { |line| line.split(',').map(&:to_i) })
      ]
    end
  end
end
