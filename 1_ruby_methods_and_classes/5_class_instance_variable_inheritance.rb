# Instance variables are set only for a specific instance. Can't be inherited.
# Class variables are set accross a class and all it's subclasses.

# _________________________________________________________________________
# Instance variables
# Available for all instances of the class. They should be initialized with instance creation or after,
# during the code execution, otherwise they won't be available.

class Square
  @sides = 4

  def square_sides
    @sides
  end
end

s = Square.new
p s.square_sides # => nil -> because @sides instance varibale was not initialized
p s # => #<Square:0x00007fbf9a995d70>

class Triange
  @sides = 4

  def trinagle_sides
    @sides = 3
  end
end

t = Triange.new
p t.trinagle_sides # => 3 -> because @sides instance varibale was initialized
p t # => #<Triange:0x00007f8c340d5148 @sides=3>

class Pentagon
  def sides
     p @sides = 5
  end

  def angle
    p @sides
    p @angle = 60
  end

  def data
    p @sides
    p @angle
  end
end

pentagon = Pentagon.new
pentagon.data  # => nil, nil
pentagon.angle # => nil, 60
pentagon.sides # => 5
pentagon.data  # => 5, 60

# _________________________________________________________________________
# Class variables
# Shared among all descendants.

class Employee
  @@rights = ['list', 'create'] # => class variables are defined with @@
end

class Support < Employee; end

class Admin < Employee
  @@rights << 'delete'
end

p Employee.class_variable_get(:@@rights) # => ['list', 'create', 'delete']
p Employee.class_variable_get(:@@rights) # => ['list', 'create', 'delete']
p Admin.class_variable_get(:@@rights) # => ['list', 'create', 'delete']

# _________________________________________________________________________
# Validations example with class variables
# class variables will be shared across all subclasses and this isn't what we want

class ApplicationRecord
  @@validations = {}

  def self.validates(name, **options)
    @@validations[name] = options
  end

  def self.validations
    @@validations
  end
end

class User < ApplicationRecord
  validates :name, presence: true
end

class Project < ApplicationRecord; end

p ApplicationRecord.validations # => {:name=>{:presence=>true}}
p User.validations # => {:name=>{:presence=>true}}
p Project.validations # => {:name=>{:presence=>true}}

# _________________________________________________________________________
# Validations example with instance variables
# To work with instance variables we need to define the same instance variable in each subclass

class ApplicationRecord1
  @validations = {}

  def self.validates(name, **value)
    @validations[name] = value
  end

  def self.validations
    @validations
  end
end

class Task1 < ApplicationRecord1
  @validations = {}

  validates :name, presence: true
end

class Project1 < ApplicationRecord1
  @validations = {}
end

p ApplicationRecord1.validations # => {}
p Task1.validations # => {:name=>{:presence=>true}}
p Project1.validations # => {}

# _________________________________________________________________________
# Validations example with self.inherited method
# def self.inherited(subclass) method allows to see all inherited objects
# def self.inherited(subclass) method is invoked everytime when subclass is called

class ApplicationRecord2
  def self.inherited(subclass)
    # puts base # => Task2, Project2, SubTask2
    subclass.instance_variable_set(:@validations, @validations&.dup || {})
  end

  def self.validates(name, **value)
    @validations[name] = value
  end

  def self.validations
    @validations
  end
end

class Task2 < ApplicationRecord2
  validates :name, presence: true
end

# by setting @validations || {} in ApplicationRecord2.inherited, we allow parent validations from Task2 class to
# be also used in SubTask2 class
# @validations&.dup allows to allocate different objects in memory to use validations for parent and all subclasses.
# Without this .dup method parent class and all subclasses will have the same not unique validations
class SubTask2 < Task2
  validates :description, presence: true
end

class Project2 < ApplicationRecord2; end

p Task2.validations # => {:name=>{:presence=>true}}
p SubTask2.validations # => {:name=>{:presence=>true}, :description=>{:presence=>true}}
p Project2.validations # => {}

p Task2.validations.object_id # => 60
p SubTask2.validations.object_id # => 80
p Project2.validations.object_id # => 100

# _________________________________________________________________________
