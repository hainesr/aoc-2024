# frozen_string_literal: true

# Advent of Code 2024
#
# Robert Haines
#
# Public Domain

require 'rake/testtask'
require 'rubocop/rake_task'

task default: :test

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Run code for a day, or days, of advent of code'
task :run do
  ARGV[1..].each do |day|
    day = day.chomp.to_i
    next if day.negative? || day > 25

    system "./aoc-2024 #{day}"
    puts
  end

  exit
end

RuboCop::RakeTask.new
