# _________________________________________________________________________
# DSL creation. Version with 'method_missing'

# class Configuration
#   def initialize
#     @config = {}
#   end

#   def method_missing(name, args=nil)
#     # Setting config value
#     if name.to_s.end_with?('=')
#       @config[name.to_s[0..-2]] = args

#     # Retriving config value
#     else
#       @config[name.to_s]
#     end
#   end
# end

# class Rails
#   def self.configure(&block)
#     self.instance_eval(&block)
#   end

#   def self.config
#     @config ||= Configuration.new
#   end
# end

# Rails.configure do
#   config.feature_1 = true
#   config.feature_2 = false
# end

# p Rails.config # => #<Rails::Configuration:0x00007ff24d186ef0 @config={"feature_1"=>true, "feature_2"=>false}>
# p Rails.config.feature_1 # => true
# p Rails.config.feature_2 # => false


# _________________________________________________________________________
# DSL creation. Version with 'define_method'

class Configuration
  def initialize(*attributes)
    @config = {}

    attributes.each do |attribute|
      define_singleton_method(attribute) do
        @config[attribute]
      end

      define_singleton_method(:"#{attribute}=") do |value|
        @config[attribute] = value
      end
    end
  end
end

class Rails
  def self.configure(&block)
    self.instance_eval(&block)
  end

  def self.config
    @config ||= Configuration.new(:feature_1, :feature_2)
  end
end

Rails.configure do
  config.feature_1 = true
  config.feature_2 = false
end

p Rails.config # => #<Rails::Configuration:0x00007ff24d186ef0 @config={"feature_1"=>true, "feature_2"=>false}>
p Rails.config.feature_1 # => true
p Rails.config.feature_2 # => false

config = Configuration.new(:foo)
config.foo = 'hello'
p config.foo # => 'hello'
p config # => #<Configuration:0x00007fb1ba0ce428 @config={:foo=>"hello"}>
# _________________________________________________________________________