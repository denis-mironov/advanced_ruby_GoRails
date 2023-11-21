# _________________________________________________________________________
# define_method
# Allows to define methods dynamically.

arr = [:create, :update, :destroy]

# it will dynamically create 3 new methods
arr.each do |name|
  define_method(name) do
    "Method info: #{method(name)}"
  end
end

p create  # => "Method info: #<Method: Object#create() 4_define_method.rb:9>"
p update  # => "Method info: #<Method: Object#update() 4_define_method.rb:9>"
p destroy # => "Method info: #<Method: Object#destroy() 4_define_method.rb:9>"

# _________________________________________________________________________
# define_method with arguments

arr = [:edit, :delete]
arr.each do |name|
  define_method(name) do |id, title|
    "Method arguments: id: #{id}, title: #{title}"
  end
end

p edit(1, 'foo')   # => "Method arguments: id: 1, title: foo"
p delete(2, 'bar') # => "Method arguments: id: 2, title: bar"

# _________________________________________________________________________
#

class User
  @@attributes = [:id, :email, :name]

  def initialize
    @attributes = {}
  end

  @@attributes.each do |name|
    define_method(:"add_#{name}") do |value|
      @attributes[name] = value
    end

    define_method(name) do
      @attributes[name]
    end
  end

  # results of define_method

  # def add_id(id)
  #   @attributes[:id] = id
  # end

  # def add_email(email)
  #   @attributes[:email] = email
  # end

  # def add_name(name)
  #   @attributes[:name] = name
  # end

  # def id
  #   @attributes[:id]
  # end

  # def email
  #   @attributes[:email]
  # end

  # def name
  #   @attributes[:name]
  # end
end

user = User.new
user.add_id(1)
user.add_email('test@test.com')
user.add_name('John Doe')

p user.instance_variable_get(:@attributes)
p user.id
p user.email
p user.name

# _________________________________________________________________________
