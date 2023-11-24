# _________________________________________________________________________
# The Singleton pattern.
# It's an object-oriented programming pattern where you make sure to have 1 and only 1 instance of some class.
# Ruby implement the Singleton pattern with a module, you need to require and include Singleton.

# This module basically hides the ':new' method. MySingletonObject.new will always ERROR. Instead, it will give you an instance method that will always return the same unique instance of your class.

# This is useful if you ever want to restrict a class so it never creates more than one instance of itself.

require 'singleton'

class User
  include Singleton

  # 'initialize' is called everytime an instance is created
  def initialize
    puts 'This will be printed once'
  end

  def self.hello
    'hello'
  end
end

# User.new # => private method `new' called for User:Class (NoMethodError)
# This ensures that only one instance of Klass can be created.
 a = User.instance # => This will be printed once
 b = User.instance
 p a == b

 p User.hello

# _________________________________________________________________________
