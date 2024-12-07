# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'rubygems'
require 'bundler/setup'

require 'aoc2024/day'

module AOC2024
  INPUT_DIR = ::File.expand_path('../etc', __dir__)

  DAY_MAP = [
    'there_is_no_day_zero',     # Day 0
    'historian_hysteria',
    'red_nosed_reports',
    'mull_it_over',
    'ceres_search',
    'print_queue',              # Day 5
    'guard_gallivant',
    'bridge_repair'
  ].freeze

  def self.class_from_day(day)
    class_name = day.split('_').map(&:capitalize).join
    class_path = "AOC2024::#{class_name}"
    class_path.split('::').reduce(Object) { |o, c| o.const_get c }
  end
end
