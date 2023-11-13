# USE ALIAS FUNCTIONALITY IN RUBY CAREFULLY, BECAUSE THEY ARE REALLY DANGEROUS!!!

# 3 places where alias functionality can be needed:
  # 1. Misspelling names of methods - cancelled / canceled, color / colour
  # 2.
  # 3.

# _________________________________________________________________________
# Alias

class Subscription
  def canceled?
    false
  end

  alias cancelled? canceled? # ruby key word - no comma is needed
end

puts Subscription.new.cancelled? # => false

# _________________________________________________________________________
# Alias method

  class Subscription
    def canceled?
      false
    end

    alias_method :cancelled?, :canceled? # not ruby key word - comma should be used
  end

  puts Subscription.new.cancelled? # => false

# _________________________________________________________________________
# Alias with method overriding - WRONG way

class User
  def name
    'Denis'
  end

  alias full_name name
end

puts User.new.full_name # => Denis

class Admin < User
  def name
    'Admin'
  end
end

puts Admin.new.name # => Admin
puts Admin.new.full_name # => Denis, still returns the name of the User

# _________________________________________________________________________
# Alias with method overriding - CORRECT way

class User
  def name
    'Denis'
  end

  def full_name
    name
  end
end

puts User.new.full_name # => Denis

class Admin < User
  def name
    'Admin'
  end

  def full_name
    name
  end
end

puts Admin.new.full_name # => Admin, returns the right Admin name
# _________________________________________________________________________
