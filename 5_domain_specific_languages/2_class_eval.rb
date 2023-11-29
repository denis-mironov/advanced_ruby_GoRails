# _________________________________________________________________________
# 'class_eval' method - evaluates the string or block in the context of the class,
# allowing you to reopen the class and define additional behavior on it.

# Creating a method inside the block defines an instance method on the class.
# Using 'class_eval' on a class is the same as explicitly defining the method in the class itself. Benefits:
#  1 - allows you to add behavior to a class dynamically.
#  2 - the code will fail immediately, if the class doesn’t exist (or if you misspelled the class name).

require 'active_support'
require 'active_support/core_ext'

class Greeting
  GREETING_TIME = '8:00'

  def initialize(text)
    @text = text
  end

  def person_name
    'John Doe'
  end

  private

  def called_at
    DateTime.current
  end
end

Greeting.class_eval do
  GREETING_DATE = Date.current

  def welcome
    "#{self.object_id}: this is greeting"
  end

  def person_welcome
    "#{self.object_id}: this is greeting from #{person_name}"
  end

  def time_and_reminder
    "Time: #{Greeting::GREETING_TIME}, called at: #{called_at}"
  end
end

greeting = Greeting.new('Hello World')

p Greeting.singleton_methods # => []
p Greeting.instance_methods  # => [:welcome, :person_welcome, :time_and_reminder, ...]
p greeting.welcome           # => "80: this is greeting"
p greeting.person_welcome    # => "80: this is greeting from John Doe"
p greeting.time_and_reminder # => "Time: 8:00, called at: 2023-11-28T16:15:25+01:00"


# _________________________________________________________________________
