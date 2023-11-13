require 'active_support/all'

# _________________________________________________________________________
# Monkey patching of Integer class
# In this case, calling any standard Integer method for days / hours / minutes will cause an error, since
# our monkey patches are returning an integer value, while standard methods are waiting for ActiveSupport::Duration

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

puts 2.hours.ago # => undefined method `ago' for 7200:Integer (NoMethodError)

# _________________________________________________________________________
# Monkey patching of Integer class (Refined version)
# In this case monkey patch is used only in place where you 'using TimeHelpers' module

module TimeHelpers
  refine Integer do
    def days
      24 * hours
    end

    def hours
      60 * minutes
    end

    def minutes
      60 * self
    end

    def milliseconds
      self * 1000
    end
  end
end

# Now our monkey patches are only implemented within the Person class
class Person
  using TimeHelpers

  puts 2.hours # => 7200
  puts 3.days # => 259200
  puts 5.minutes # => 300
  puts 5.milliseconds # => 5000

  puts 5.milliseconds.class # => Integer
end

# Outside the Person class this implementation will return an error
puts 5.milliseconds # => undefined method `milliseconds' for 5:Integer (NoMethodError)
# _________________________________________________________________________
