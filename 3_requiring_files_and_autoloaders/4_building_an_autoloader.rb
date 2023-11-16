# _________________________________________________________________________
# 1st possible Autoloader version:

# When needed code is not loaded, there will be a next error:
# uninitialized constant Authorization (NameError)

# most rudimentary autoloader, not really good way because you need to build this require everywhere in the code.
begin
  Authorization
rescue NameError => e
  require_relative "../concerns/#{e.message.split.last.downcase}" # => "../concerns/authorization"
end

# _________________________________________________________________________
# 2nd possible Autoloader version:

# 'self.const_missing(name)' method returns a constant (in our case it's an Authorization) which was not loaded into the current direction.
class Object
  def self.const_missing(name) # => :Authorization (symbol)
    require_relative "../concerns/#{name.to_s.downcase}" # => will require the code
    const_get(name) # => Authorization, this methos return the class name
  end
end

Authorization

# _________________________________________________________________________
# 3rd possible Autoloader version:

# let's add some options to the previous Autoloader
class Object
  require 'active_support'
  require 'active_support/core_ext/string' # => to require 'underscore' method

  def self.const_missing(name)
    @looked_for ||= {}
    str_name = name.to_s
    file = "../concerns/#{name.to_s.underscore}"

    raise "Class not found: #{name} in #{file}.rb" if @looked_for[str_name]

    @looked_for[str_name] = 1

    require_relative file
    klass = const_get(name) # => will try to get a constant and call 'self.const_missing' if there is no. Kind of recursion
    return klass if klass

    raise "Class not found: #{name} in #{file}.rb"
  end
end

Autoload.new.message # => "This file was autoloaded"
AutoloadWithError.new.message # => Class not found: AutoloadWithError in ../concerns/autoload.rb (RuntimeError)

# _________________________________________________________________________
