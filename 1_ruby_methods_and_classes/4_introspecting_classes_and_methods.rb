# _________________________________________________________________________
# Class self and instance methods

class Person
  def self.speak # Equals to Person.speak
    puts 'Class speaks'
  end

  def speak
    puts 'Instance speaks'
  end
end

Person.speak # => 'Class speaks'
Person.new.speak # => 'Instance speaks'

Person.singleton_methods # => self methods of the class
Person.instance_methods # => all class instance methods which are comming from Person.ancestors
Person.ancestors # => Parent classes which are Person inherits from: [Person, Object, PP::ObjectMixin, Kernel, BasicObject]
Person.descendants # => List of subclasses

# _________________________________________________________________________
# Setting instance variables

person = Person.new
person.instance_variable_set(:@name, 'Denis')
person.instance_variable_set(:@surname, 'Mironov')

person # => #<Person:0x00007f9da81cc4b8 @name="Denis", @surname="Mironov">

puts person.instance_variable_get(:@name) # => Denis
puts person.instance_variable_get(:@surname) # => Mironov

# _________________________________________________________________________
# EVERYTHING IS OBJECT IN RUBY

p [
    5,
    'hello',
    [1, 2, 3],
    {'hello' => 'ruby'},
    person,
    method(:puts),
    Person,
    Class,
    Object,
    Kernel,
    BasicObject
  ].map{ |e| e.kind_of?(Object) } # => [true, true, true, true, true, true, true, true, true, true]

p [
    5,
    'hello',
    [1, 2, 3],
    {'hello' => 'ruby'},
    person,
    method(:puts),
    Person,
    Class,
    Object,
    Kernel,
    BasicObject
  ].map(&:class) # => [Integer, String, Array, Hash, Person, Method, Class, Class, Class, Module, Class]
# _________________________________________________________________________
