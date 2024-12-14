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

    def part2 # rubocop:disable Metrics/AbcSize
      backward_index = @file_blocks.length - 1
      free_space_filled = @free_space.map { 0 }
      sum = 0

      loop do
        # Is there any free space big enough for the last file block?
        pos = @free_space.index { |fs| fs >= @file_blocks[backward_index] }

        # Don't overshoot where the file block is currently.
        if pos.nil? || pos >= backward_index
          # No suitable free space, so checksum the file in place.
          position = @file_blocks[...backward_index].sum +    # Sizes of all previous file blocks.
                     @free_space[...backward_index].sum +     # Sizes of all previous free spaces.
                     free_space_filled[...backward_index].sum # Sizes of all previous filled free spaces.

          @file_blocks[backward_index].times do
            sum += position * backward_index
            position += 1
          end
        else
          # Found suitable free space, so fill the free space with the file block and checksum.
          position = @file_blocks[..pos].sum +    # Sizes of all file blocks up to the free space.
                     @free_space[...pos].sum +    # Sizes of all previous free spaces.
                     free_space_filled[..pos].sum # Sizes of all filled free spaces up to the free space.

          @file_blocks[backward_index].times do
            sum += position * backward_index
            position += 1
          end

          # Adjust the free space left where we've just moved the file to, and
          # keep track of the space we've filled.
          @free_space[pos] -= @file_blocks[backward_index]
          free_space_filled[pos] += @file_blocks[backward_index]
        end

        backward_index -= 1
        return sum if backward_index.zero?
      end
    end

    def read_disk_map(input)
      input.chars.map(&:to_i).partition.with_index { |_, i| i.even? }
    end
  end
end
