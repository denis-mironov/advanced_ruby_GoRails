# _________________________________________________________________________
# Eigenclass.
# This is a copy of the parent class with all its functionality but for a specific instance.
# It's extendable and modifiable.

class User
  p self # => User

  def hello
    puts 'hello'
  end
end

user = User.new
user.hello # => 'Hello'

# This construction will reopen the class only for the single instance 'user'.
# This is an Eigenclass. #<Class:#<User:0x00007f9b540781d0>> it is the anonymous subclass of User class
# which inherits all the User functionality for the 'user' instance and it's modifiable

another_user = User.new

class << user
  p self # => #<Class:#<User:0x00007f9b540781d0>>

  def hello
    p 'Hey'
  end

  def greeting
    p 'Hey, John'
  end
end

class << another_user
  p self # => #<Class:#<User:0x00007fb1b198fd40>>

  def hello
    p 'Merhaba'
  end
end

user.hello            # => 'Hey'
user.greeting         # => 'Hey, John'
another_user.hello    # => 'Merhaba'
another_user.greeting # => undefined method `greeting' for #<User:0x00007fad700e3b00> (NoMethodError)

# _________________________________________________________________________
