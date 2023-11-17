# _________________________________________________________________________
# Example of using respond_to? method.
# In the next example we will have errors with responsd_to? method and obj.method(:method), because, using
# the 'method_missing', we dont't define any methods physically in the class.

class User
  # Sets attr_reader for given name and assigns an instance variable
  def method_missing(name, *args, &block)
    if name.to_s.include?('add_')
      attr_name = name.to_s[4..-1]
      self.class.send(:attr_reader, attr_name)

      attr_value = block_given? ? block.call : args.first
      self.instance_variable_set("@#{attr_name}", attr_value)
    else
      self.instance_variables.include?(name) ? name : super
    end
  end

  def respond_to?(method_name)
    true
  end
end

user = User.new
p user.respond_to?(:email)  # => true
p user.respond_to?(:email=) # => true
p user.respond_to?(:upcase) # => true

p user.method(:email) # => undefined method `email' for class `User' (NameError), because this method is not physically defined.

# _________________________________________________________________________
# Solution of the problem
# Our main problem was that we created an object working with 'method_missing' and allowing us to work
# with any methods but not responding to those methods.
# 'respond_to_missing?(method_name, *args)' solves this problem.

class User
  def method_missing(name, *args, &block)
    if name.to_s.include?('add_')
      attr_name = name.to_s[4..-1]
      self.class.send(:attr_reader, attr_name)

      attr_value = block_given? ? block.call : args.first
      self.instance_variable_set("@#{attr_name}", attr_value)
    else
      self.instance_variables.include?(name) ? name : super
    end
  end

  # requires 2 arguments
  def respond_to_missing?(method_name, *args)
    true
  end
end

user = User.new
p user.respond_to?(:email)  # => true
p user.respond_to?(:email=) # => true
p user.respond_to?(:upcase) # => true

p user.method(:email)  # => #<Method: User#email(*)>
p user.method(:email=) # => #<Method: User#email=(*)>
p user.method(:upcase) # => #<Method: User#upcase(*)>

# _________________________________________________________________________
# Allowed attributes
# Along with the attributes we define in 'initialize' method, there are always some 'allowed attributes',
# which ActiveRecord creates looking at your DB. Ex: id, created_at, updated_at, any other field of the table.
# We will do something similar in this method.

class User
  attr_reader :allowed

  def initialize
    @allowed = [:id, :created_at, :email]
  end

  def method_missing(name, *args, &block)
    if !respond_to_missing?(name)
      super
    elsif name.to_s.include?('add_')
      attr_name = name.to_s[4..-1]
      self.class.send(:attr_reader, attr_name)

      attr_value = block_given? ? block.call : args.first
      self.instance_variable_set("@#{attr_name}", attr_value)
    else
      self.instance_variables.include?(name) ? name : super
    end
  end

  def respond_to_missing?(method_name, *args)
    allowed.include?(method_name.to_s.gsub('add_', '').to_sym) || super
  end
end

user = User.new
p user.respond_to?(:add_email)  # => true
p user.respond_to?(:email)      # => true
p user.respond_to?(:created_at) # => true
p user.respond_to?(:phone)      # => false
p user.respond_to?(:upcase)     # => false

p user.method(:add_email)  # => #<Method: User#email(*)>
p user.method(:email)      # => #<Method: User#email=(*)>
p user.method(:phone)      # => undefined method `phone' for class `User' (NameError)
p user.method(:upcase)     # => undefined method `upcase' for class `User' (NameError)

# _________________________________________________________________________
