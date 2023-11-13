# _________________________________________________________________________
# Simple example of monkey patching

class Person
  def hello
    puts 'Hello!'
  end
end

person = Person.new

class Person
  def hello
    puts 'Hello man!'
  end
end

person.hello # => Hello man!

# _________________________________________________________________________
# Monkey patching of Integer class
# All methods are printing seconds / Integer

class Integer
  def days
    24 * hours
  end

  def hours
    60 * minutes
  end

  def minutes
    60 * self
  end
end

puts 2.hours # => 2*60*60 => 7200
puts 3.days # => 3*24*60*60 => 259200
puts 5.minutes # => 5*60  => 300
# _________________________________________________________________________
