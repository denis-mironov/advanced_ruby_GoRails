# _________________________________________________________________________
# Instance methods.
# They are available only for the instances of the class

class User
  def hello
    p 'Hello'
  end

  def greeting
    p 'Hello, John'
  end
end

user = User.new
other_user = User.new

user.hello          # => 'Hello'
user.greeting       # => 'Hello, John'
other_user.hello    # => 'Hello'
other_user.greeting # => 'Hello, John'
# User.hello          # => undefined method `hello' for User:Class (NoMethodError)

# _________________________________________________________________________
# Class (self) methods.
# They are available only for the class itself

class Customer
  def self.hello
    p 'Hey'
  end

  def self.greeting
    p 'Hey, John'
  end
end

customer = Customer.new

Customer.hello    # => 'Hey'
Customer.greeting # => 'Hey, John'
# customer.hello    # => undefined method `hello' for #<Customer:0x00007f991d8ab548> (NoMethodError)
# customer.greeting # => undefined method `greeting' for #<Customer:0x00007f991d8ab548> (NoMethodError)

# _________________________________________________________________________
# Eigenclass methods.
# They are available only for the specific instance of the class

specific_user = User.new
specific_user_2 = User.new

class << specific_user
  def hello
    p 'Hello from specific user'
  end

  def greeting
    p 'Hello, I\'m a specific user'
  end
end

# different way of defining eigenclass
def specific_user_2.hello
  p 'Hello from specific user 2'
end

def specific_user_2.greeting
  p 'Hello, I\'m a specific user 2'
end

user.hello               # => 'Hello'
user.greeting            # => 'Hello, John'
specific_user.hello      # => 'Hello from specific user'
specific_user.greeting   # => 'Hello, I\'m a specific user'
specific_user_2.hello    # => 'Hello from specific user 2'
specific_user_2.greeting # => 'Hello, I\'m a specific user 2'

# _________________________________________________________________________
