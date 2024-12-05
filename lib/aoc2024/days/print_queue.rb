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
      @rules, @pages = read_input(input)
    end

    def part1
      @pages.sum do |pages|
        correct_order?(@rules, pages) ? pages[pages.size / 2] : 0
      end
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
