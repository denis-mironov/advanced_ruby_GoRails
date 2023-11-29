# _________________________________________________________________________
# 'instance_eval' method - Evaluates a string containing Ruby source code, or the given block
# in the context of the receiving object.

# Can be called on
#  - class (because any class is an instance of Class object)
#  - instance of class

require 'active_support'
require 'active_support/core_ext'

class Greeting
  GREETING_TIME = '8:00'
  @reminder = '9:00'

  def initialize(text)
    @text = text
  end

  def self.person_name
    'John Doe'
  end

  private

  def called_at
    DateTime.current
  end
end

# _________________________________________________________________________
# Call on class - adds class method to the Greeting class.
# It gives an access to all class methods and allowable variables of the class

Greeting.instance_eval do
  GREETING_DATE = Date.current

  def welcome
    "#{self.name}, #{self.object_id}: this is greeting"
  end

  def person_welcome
    "#{self.name}, #{self.object_id}: this is greeting from #{person_name}"
  end

  def time_and_reminder
    "Time: #{self::GREETING_TIME}. Reminder: #{@reminder}"
  end
end

p Greeting.welcome           # => "Greeting, 60: this is greeting"
p Greeting.person_welcome    # => "Greeting, 60: this is greeting from John Doe"
p Greeting.time_and_reminder # => "Time: 8:00. Reminder: 9:00"
p GREETING_DATE              # => Date.current
p Greeting.singleton_methods # => [:welcome, :person_welcome, :time_and_reminder, :person_name]

# greeting_one = Greeting.new('Hello World')
# p greeting_one.welcome # => undefined method `welcome' for #<...> (NoMethodError)
# p greeting_one.person_welcome # => undefined method `person_welcome' for #<...> (NoMethodError)


# _________________________________________________________________________
# Call on instance of the class - defines a method on that specific instance.
# No other instances of the class can access that method.
# Works like an 'Eigenclass' -> 4_metaprogramming/6_eigenclass.rb

greeting_two = Greeting.new('Hello World')
greeting_three = Greeting.new('Hello World')

greeting_two.instance_eval do
  def personal_greeting
    'Specific to greeting two'
  end

  def called_at_time
    called_at
  end
end

p greeting_two.personal_greeting   # => "Specific to greeting two"
p greeting_two.called_at_time      # => DateTime.current
p greeting_three.send(:called_at)  # => DateTime.current
p greeting_three.instance_eval { called_at }  # => DateTime.current
# p greeting_three.called_at         # => undefined method `called_at' for #<...> (NoMethodError)
# p greeting_three.personal_greeting # => undefined method `personal_greeting' for #<...> (NoMethodError)


# _________________________________________________________________________
# 'instance_eval' with a string

string = 'String'
other_string = 'Other string'
another_string = 'Another string'

string.instance_eval do
  def reverse_letters
    self.reverse
  end
end

# Eigenclass example
class << other_string
  def reverse_symbols
    self.reverse
  end
end

p string.reverse_letters       # => 'gnirtS'
p other_string.reverse_symbols # => undefined method `reverse_letters' for "Other string":String (NoMethodError)
# p another_string.reverse_letters # => undefined method `reverse_letters' for "Another string":String (NoMethodError)
# p another_string.reverse_symbols # =>  undefined method `reverse_symbols' for "Another string":String (NoMethodError)

# _________________________________________________________________________
