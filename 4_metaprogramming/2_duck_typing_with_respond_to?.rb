# _________________________________________________________________________
# respond_to? method
# It let you to identify that a certain Obj is able to take certain method and return true or false.
# Duck type in ruby - an object that acts like a duck, quacks like a duck, but we don't care if it's duck or not,
# it just needs to work like a duck does:)

1.respond_to?(:upcase) # => false
'abc'.respond_to?(:upcase) # => true
[].respond_to?(:include?) # => true
{}.respond_to?(:include?) # => true
[].respond_to?(:key) # => false
{}.respond_to?(:key) # => true

# _________________________________________________________________________
# Example of using respond_to? method

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
# p user.respond_to?(:name) # => false. Not correct, because method_missing is responsible every single method missing

p user.respond_to?(:add_name) # => true
p user.respond_to?(:upcase) # => true, but user will never be respond to :upcase method, so we created a dangerous situation here!

# _________________________________________________________________________