# ___________________________________________________________________________________________________
# ARGV (argument values) - command line arguments in Ruby.
# It takes arguments separated with space from the command line and puts them into array.
# Works only with one-dimensional arrays. EX:

# command line: ruby 7_rake_from_scratch.rb hello arg_1 arg_2 {}
arguments_array = ARGV
p arguments_array # => ["hello,", "arg_1,", "arg_2,", "{}"]


# ___________________________________________________________________________________________________
# Rake From Scratch (very simple version)
# Rake is a popular task runner in Ruby, it centralizes access to your tasks.

TASKS = {}

class Task
  def initialize(name, dependencies, block)
    @name = name
    @dependencies = dependencies
    @block = block
  end

  def call
    return if @already_run

    @dependencies.each { |dep| TASKS[dep.to_s].call }
    @block.call

    @already_run = true
  end
end

def task(name, dependencies: [], &block)
  TASKS[name.to_s] = Task.new(name, dependencies, block)
end

load '../lib/Rakefile' # => load will still run Rakefile as a ruby file even if there is no .rb extension

ARGV.each do |name|
  if TASKS.has_key?(name)
    TASKS[name].call
  else
    p "No task with name '#{name}' defined"
  end
end

# ___________________________________________________________________________________________________