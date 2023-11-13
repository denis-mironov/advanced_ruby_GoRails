# _________________________________________________________________________
# Splat operator (with one asterics - *)
# Splat operator can take an infinite number of arguments and convert them to an array

def example1(*args)
  p args
end

example1([1,2,3,4,5])            # => [[1, 2, 3, 4, 5]]
example1(nil)                    # => [nil]
example1()                       # => []
example1(1,2,3,'str', {}, [1,2]) # => [1, 2, 3, "str", {}, [1, 2]]

# _________________________________________________________________________
# Double splat operator (with double asterics - **)
# Double splat inforces an argument to be a hash

def example2(**options)
  p options
end

example2()                     # => {}
example2(1 => 2)               # => {1=>2}
example2(name: :Denis)         # => {:name=>:Denis}
example2(foo: :bar, bar: :foo) # => {:foo=>:bar, :bar=>:foo}
example2({name: :Denis})       # => wrong number of arguments (given 1, expected 0) (ArgumentError)
example2('str')                # => wrong number of arguments (given 1, expected 0) (ArgumentError)
example2(nil)                  # => wrong number of arguments (given 1, expected 0) (ArgumentError)
example2(1, 2)                 # => wrong number of arguments (given 2, expected 0) (ArgumentError)

# _________________________________________________________________________
# Double splat operator with named keys

def example3(foo:, **options)
  p foo
  p options
end

example3(name: :Denis, foo: :bar) # => :bar, {:name=>:Denis}
example3(name: :Denis)            # => missing keyword: :bar (ArgumentError)

# Ruby also allows it to work without double splat, in this case argument is not inforced to be a hash
def example4(a, b, options)
  p a, b, options
end

example4(1, 2, 3)             # => 1, 2, 3
example4(1, 2, hello: :world) # => 1, 2, {:hello=>:world}
example4(1, 2)                # => wrong number of arguments (given 2, expected 3) (ArgumentError)

# _________________________________________________________________________
# Double splat operator example

def div(content, **options)
  attributes = options.map{ |k, v| "#{k} = '#{v}'" }.join(' ')
  p "<div #{attributes}>#{content}</div>"
end

div('hello')                                   # => <div >hello</div>
div('hello', class: 'text-blue')               # => <div class = 'text-blue'>hello</div>
div('hello', class: 'text-blue', 'data-id': 1) # => <div class = 'text-blue' data-id = '1'>hello</div>
# _________________________________________________________________________
