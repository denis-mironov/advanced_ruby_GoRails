# _________________________________________________________________________
# Include Module - adds module to the ancestors list and allow an INSTANCE to use it's methods.
# Ancestors chain ex: [YourClass, IncludedModule, Object, Kernel, BasicObject]

# You need to use 'include' if you want to overwrite methods from included module, because ruby will
# find overwritten method in your class and return it and won't go to upper levels / ancestors trying
# to find this method again.

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
# Include Module from required file

class RegisteredUser
  require_relative '../lib/account_history'
  include AccountHistory

  def created_at
    Date.yesterday
  end
end

user = RegisteredUser.new
# p user.registered_at # => unless I include the module -> undefined method `registered_at'(NoMethodError)
p user.created_at # => Date yesterday
p user.registered_at # => Date today
p user.registration_expires_at # => Date today + 1 year
p User.ancestors # => [User, Active, Object, Kernel, BasicObject]

# _________________________________________________________________________
# Extend Module - adds methods of extended module to the class itself (to singleton methods)

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
# Prepend Module - works as 'include', but adds a module before the class in ancestors chain.
# Useful if you want to wrap some logic around your methods.
# Ancestors chain ex: [IncludedModule, YourClass, Object, Kernel, BasicObject]

# If you use 'prepend' for a module, this means that you can't overwrite methods from this module,
# because ruby will find these methods in the module and return them and won't go to upper levels / ancestors
# trying to find them again.

module CustomerData
  def wallet_id
    '123456'
  end

  def account_id
    '654321'
  end
end

class Customer
  prepend CustomerData
end

customer = Customer.new
# p Customer.wallet_id # => undefined method `wallet_id' for #<Customer:0x007fb80b814e38> (NoMethodError)
p Customer.ancestors # => [CustomerData, Customer, Object, Kernel, BasicObject]
p Customer.instance_methods # => [:wallet_id, :account_id, ...]
p Customer.singleton_methods # => []
p customer.wallet_id # => '12356'
p customer.account_id # => '654321'

# _________________________________________________________________________