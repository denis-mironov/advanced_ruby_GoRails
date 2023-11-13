# Difference between Blocks, Procs and Lambdas
#   1 - Arguments to blocks and procs are optional, arguments to lambda are required
#   2 - 'Return' and 'break' behaves differently in procs and lambdas
#   3 - 'Next' behaves same way in both procs and lambdas

# ___________________________________________________________________________________________________
# Block

def block_method
  p yield
end

block_method { 'Hello block!' }
block_method { |el| el } # => el is not defined, block_method will print nil and not raise an error

# While we are using standard yield to work with a block - it's a block, but when we define a '&block'
# argument for a method, it becomes a Proc! '&' makes it a Proc!

def block_method(&block)
  p block # => #<Proc:0x00007fb3e88babe8 2_blocks_procs_lambdas.rb:21>
end

block_method { 'Hello block!' }

# ___________________________________________________________________________________________________
# Proc
# We can define proc with 2 different formats:

proc {}
Proc.new {}

proc1 = proc { p 'Hello Proc!' }
proc1.call # => 'Hello Proc!'

proc2 = Proc.new { |el| p el }
proc2.call # => el is not defined, proc will print 'nil' and not raise an error

proc3 = Proc.new { |x, y| puts 'I don\'t care about arguments!' }
proc3.call # => 'I don't care about arguments!'

# ___________________________________________________________________________________________________
# Lambdas
# We can define lambdas with 2 different formats:

lambda {}
-> {}

lambda1 = lambda { p 'Hello Lambda!' }
lambda1.call  # => 'Hello Lambda!'

lambda2 = lambda { |int| p int }
lambda2.call(3) # => 3

# lambda3 = ->(int) { p int }
# lambda3.call() # => el is not defined, lambda will raise an argument error

# ___________________________________________________________________________________________________
# Passing procs and lambdas to another methods

def proc_lambda_method(&block)
  el = block.call
  test_method(el)
end

def test_method(el)
  p el.call
end

lambda = -> { 'Hello Lambda!' }
proc = Proc.new { 'Hello Proc!' }

proc_lambda_method { lambda } # => 'Hello Lambda!'
proc_lambda_method { proc } # => 'Hello Proc!'

# ___________________________________________________________________________________________________
# Return function in Proc and Lambda

def proc_method
  proc = Proc.new { return 'Hello' } # => returns not the result of the function, but exits the method
  proc.call + ' World'
end

def lambda_method
  lambda = -> { return 'Hello' } # => standard return function
  lambda.call + ' World'
end

p proc_method # => "Hello"
p lambda_method # => "Hello World"

# ___________________________________________________________________________________________________
# Block, Proc and Lambda usage examples

def arguments_example
  yield 1, 2
  yield 2, 3
  yield 3, 4
end
arguments_example { |n1, n2| puts n1 + n2 + 10 } # => 13, 15, 17

factor = proc { |n| n+1 }
p [1,2,3,4,5].map(&factor) # => [2, 3, 4, 5, 6]

times_two = ->(x) { x * 2 }
p times_two.call(10) # => 20

# closure example
def call_proc(my_proc)
  count = 500
  my_proc.call
end

count = 1
my_proc = Proc.new { puts count }
p call_proc(my_proc) # => because of the ‘closure’ effect this will print 1. This happens because the proc is
# using the value of count from the place where the proc was defined, and that’s outside of the method definition.
# ___________________________________________________________________________________________________
