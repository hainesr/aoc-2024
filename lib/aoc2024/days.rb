# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

# Require all the days' code.
# This is a convenience for the `bin/console` script.
dir = File.expand_path('days', __dir__)
Dir.glob(File.join(dir, '*.rb')) { |file| require(file) }
