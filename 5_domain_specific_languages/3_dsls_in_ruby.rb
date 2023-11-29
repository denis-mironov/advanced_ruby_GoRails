# _________________________________________________________________________
# DSL (Domain Specific Language) - is a computer language that's targeted to a particular kind of problem.
# DSLs are very common in computing: examples include CSS, HTML, SQL, rake, routes, Rails config, RSpec,
# ActiveRecord, many bits of Rails, etc.

# Simple DSL creation.

# class Rails
#   def self.configure(&block)
#     self.instance_eval(&block) # it gives an access to config as a method, even if we pass it as an argument
#   end

#   def self.config
#     @config ||= {}
#   end
# end

# Rails.configure do
#   config['feature_one'] = true
#   config['feature_two'] = false
# end

# p Rails.config # => {"feature_one"=>true, "feature_two"=>false}


# _________________________________________________________________________
# Simple DSL creation. Updated version

# class Rails
#   def self.configure(&block)
#     self.instance_eval(&block)
#   end

#   def self.config
#     @config ||= {}
#   end

#   def self.feature=(value)
#     config['feature'] = value
#   end
# end

# Rails.configure do
#   feature = true
# end

# p Rails.config # => {"feature"=>true}


# _________________________________________________________________________
# Simple DSL creation. Updated version. Different features

# class Rails
#   def self.configure(&block)
#     self.instance_eval(&block)
#   end

#   def self.config
#     @config ||= {}
#   end

#   def self.method_missing(name, args)
#     config[name.to_s[0..-2]] = args
#   end
# end

# Rails.configure do
#   self.feature_1 = true
#   self.feature_2 = false
# end

# p Rails.config # => {"feature_1"=>true, "feature_2"=>false}


# _________________________________________________________________________
# Simple DSL creation. Updated version. Final example

class Rails
  class Configuration
    def initialize
      @config = {}
    end

    def method_missing(name, args)
      @config[name.to_s[0..-2]] = args
    end
  end

  def self.configure(&block)
    self.instance_eval(&block)
  end

  def self.config
    @config ||= Configuration.new
  end
end

Rails.configure do
  config.feature_1 = true
  config.feature_2 = false
end

p Rails.config # => #<Rails::Configuration:0x00007ff24d186ef0 @config={"feature_1"=>true, "feature_2"=>false}>

# _________________________________________________________________________

