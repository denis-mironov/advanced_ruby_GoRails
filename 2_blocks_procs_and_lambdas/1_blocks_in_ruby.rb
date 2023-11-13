# Blocks in Ruby are snippets of code that can be created to be executed later.

# ___________________________________________________________________________________________________
# Simple benchmark example without blocks

def benchmark(code)
  start_time = Time.now

  eval code # not the best way, there can be syntax error, not evaluated until it heats the eval

  end_time = Time.now
  puts "Tooks #{end_time - start_time} seconds to execute"
end

benchmark('sleep 1') # => Tooks 1.001171 seconds to execute

# ___________________________________________________________________________________________________
# Blocks. Simple benchmark example
# We can pass block to a method without defining any arguments on a method itself.
# block_given? - special method that checks if block was passed to a method or not
# We can assign results of a block to a variable

def benchmark
  start_time = Time.now

  yield if block_given?

  end_time = Time.now
  puts "Tooks #{end_time - start_time} seconds to execute"
end

benchmark { sleep 1 } # => Tooks 1.001171 seconds to execute
benchmark do
  sleep 1
end # => Tooks 1.001171 seconds to execute

# ___________________________________________________________________________________________________
# Passing an argument to a block

def benchmark
  start_time = Time.now
  yield(start_time) if block_given?

  end_time = Time.now
  puts "End time: #{end_time}"
  puts "Tooks #{end_time - start_time} seconds to execute"
end

benchmark do |start_time|
  puts "Start time: #{start_time}"
  sleep 1
end # => Tooks 1.001171 seconds to execute

# ___________________________________________________________________________________________________
# link_to helper example with standard arguments

def link_to(title, url)
  puts "<a href \"#{url}\">#{title}</a>"
end

link_to('GoRails', 'https://gorails.com') # => <a href "https://gorails.com">GoRails</a>

# ___________________________________________________________________________________________________
# link_to helper example with using blocks
# It's really useful if you want other html inside the <a></a> snippet

def div(content)
  "<div>#{content}</div>"
end

def link_to(url)
  title = yield if block_given?

  puts "<a href \"#{url}\">#{title}</a>"
end

link_to('https://gorails.com') do
  # we can create any html here
  div('GoRails')
end # => <a href "https://gorails.com"><div>GoRails</div></a>

# ___________________________________________________________________________________________________
# block.call functionality example
# In this example we can pass a block as an argument to another method,
# with 'yield' we can use a block only in the method where it passed

def calculate(&block)
  puts block.call
end

calculate { 2 * 3 } # => 6
# ___________________________________________________________________________________________________
