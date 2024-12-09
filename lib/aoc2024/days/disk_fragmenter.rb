# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'aoc2024'

module AOC2024
  class DiskFragmenter < Day
    def setup(input = read_input_file.chomp)
      @file_blocks, @free_space = read_disk_map(input)
    end

    def part1
      forward_index = 0
      backward_index = @file_blocks.length - 1
      queue = []
      position = 0
      sum = 0

      loop do
        # Checksum the file blocks.
        @file_blocks[forward_index].times do
          sum += position * forward_index
          position += 1
        end

        # Fill the queue with the file blocks at the end of the disk.
        while queue.size < @free_space[forward_index]
          break if backward_index <= forward_index

          queue.concat([backward_index] * @file_blocks[backward_index])
          backward_index -= 1
        end

        # Checksum the file blocks as they fill up free space.
        @free_space[forward_index].times do
          return sum if queue.empty?

          sum += position * queue.shift
          position += 1
        end

        forward_index += 1
        next unless backward_index < forward_index

        # Anything left in the queue here needs to be checksummed to finish off.
        queue.each do |q|
          sum += position * q
          position += 1
        end

        return sum
      end
    end

    def read_disk_map(input)
      input.chars.map(&:to_i).partition.with_index { |_, i| i.even? }
    end
  end
end
