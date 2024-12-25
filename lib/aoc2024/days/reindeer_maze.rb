# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'
require_relative '../common/a_star'

module AOC2024
  class ReindeerMaze < Day
    STEPS = [[0, -1], [-1, 0], [0, 1], [1, 0]].freeze

    def setup(input = read_input_file.chomp)
      @map, @start, @finish = read_map(input)
    end

    def part1
      max_x = @map[0].length
      max_y = @map.length

      neighbours = lambda { |node|
        x = node.x
        y = node.y

        possible_steps = STEPS.reject do |(i, j)|
          a = x + i
          b = y + j
          a.negative? || b.negative? || a > max_x || b > max_y || @map[b][a] == '#'
        end

        possible_steps.map { |step| node.dup.move(step) }
      }

      cost = lambda(&:cost)

      heuristic = lambda { |node|
        ((@finish.x - node.x) + (@finish.y - node.y))
      }

      Common::AStar.solve(@start, @finish, neighbours, cost, heuristic)
    end

    def read_map(input)
      map = input.lines(chomp: true).map(&:chars)

      start = nil
      finish = nil

      map.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          start = Node.new(x, y) if cell == 'S'
          finish = Node.new(x, y) if cell == 'E'
        end
      end

      [map, start, finish]
    end

    class Node
      FACINGS = {
        [0, 1] => :south,
        [1, 0] => :east,
        [0, -1] => :north,
        [-1, 0] => :west
      }.freeze

      ROT_COST = {
        [:east, :north] => 1,
        [:north, :west] => 1,
        [:north, :south] => 2,
        [:east, :west] => 2,
        [:east, :south] => 1,
        [:south, :west] => 1
      }.freeze

      attr_reader :x, :y

      def initialize(x, y, facing = :east)
        @x = x
        @y = y
        @facing = facing
        @rotated = 0
      end

      def move(step)
        new_facing = FACINGS[step]
        @rotated = @facing == new_facing ? 0 : ROT_COST[[@facing, new_facing].sort]

        @facing = new_facing
        @x += step[0]
        @y += step[1]

        self
      end

      def cost
        1 + (@rotated * 1000)
      end

      # In terms of equality, we only care about the position of the node.
      def ==(other)
        @x == other.x && @y == other.y
      end

      # Need to implement #eql? and #hash to use this object as a Hash key.
      alias eql? ==

      def hash
        [@x, @y].hash
      end
    end
  end
end
