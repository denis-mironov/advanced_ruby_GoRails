# _________________________________________________________________________
# Include Module - adds module to the ancestors list and allow an INSTANCE to use it's methods
# You need to use 'include' if you want to rewrite methods from included module, because ruby will
# find overwritten method in your class and return it and won't go to upper levels / ancestors trying
# to find this method.

module Active
  def active?
    true
  end
end

class User
  include Active
end

user = User.new
p user.active? # => true
p User.ancestors # => [User, Active, Object, Kernel, BasicObject]
p User.instance_methods # => [:active?, ...]

# _________________________________________________________________________
# Extend Module - adds methods of extended module to the class itself (to singleton_methods)

module ClientInfo
  def name
    'John'
  end

  def surname
    'Doe'
  end
end

class Client
  def self.account_number
    '123456789'
  end

  extend ClientInfo
end

client = Client.new
# p client.name # => undefined method `name' for #<Client:0x007fb80b814e38> (NoMethodError)
p Client.ancestors # => [Client, Object, Kernel, BasicObject]
p Client.singleton_methods # => [:account_number, :name, :surname]
p Client.name # => John
p Client.surname # => Doe

# _________________________________________________________________________
# Include and Extend module in the same time
# 'self.included(base)' -> shows all classes which included the current module
# 'self.extended(base)' -> shows all classes which extended the current module

module Active
  def self.included(base)
    p base # => User
  end

  def self.extended(base)
    p base # => Project
  end

  def active?
    true
  end
end

class User
  include Active
end

class Project
  extend Active
end

# _________________________________________________________________________
