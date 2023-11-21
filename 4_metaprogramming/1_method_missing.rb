# _________________________________________________________________________
# method_missing -> catches the call to non existing methods.
# Metaprogramming is a concept of writiing code by writing code.

def method_missing(name, *args, &block)
  p name, args, block
end

hello() # => :hello, [], nil

hello('world', 1, 2, 3) do # => :hello, ["world", 1, 2, 3], #<Proc:0x0... 1_errors_with_method_missing.rb:11>
  1 + 1
end

# _________________________________________________________________________
# Setting instance variables with method_missing

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
end

user = User.new
user.add_name('Denis')
user.add_surname('Mironov')
user.add_email('test@test.com')

p user.name      # => 'Denis'
p user.surname   # => 'Mironov'
p user.email     # => 'test@test.com'
# p user.full_name # => (NoMethodError).undefined method `full_name'

user.add_full_name() { user.name + ' ' + user.surname }
p user.full_name # => 'Denis Mironov'

p user.instance_variables # => [:@name, :@surname, :@email, :@full_name]
# _________________________________________________________________________
