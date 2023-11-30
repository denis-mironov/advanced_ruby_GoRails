# _________________________________________________________________________
# Rails route Mapper

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

# very simple interpretation of routes in Rails. We will store them in a hash.
class RouteSet
  def initialize
    @routes = {}
  end

  def draw(&block)
    mapper = RouteMapper.new(self)
    mapper.instance_eval(&block)
  end

  def add_route(type, path)
    @routes[path] = { type: type }
  end
end

class RouteMapper
  def initialize(route_set)
    @route_set = route_set
  end

  def get(name)
    @route_set.add_route('GET', name)
  end

  def post(name)
    @route_set.add_route('POST', name)
  end

  def delete(name)
    @route_set.add_route('DELETE', name)
  end
end

class Rails
  def self.configure(&block)
    self.instance_eval(&block)
  end

  def self.config
    @config ||= Configuration.new(:feature_1, :feature_2)
  end

  def self.routes
    @routes ||= RouteSet.new
  end
end

Rails.configure do
  config.feature_1 = true
  config.feature_2 = false
end

Rails.routes.draw do
  get :about
  post :users
  delete :project

  p self # => #<RouteMapper:0x00007fc4251656e8 @route_set=#<RouteSet:0x00007fc425165878 @routes={:about=>{:type=>"GET"}, :users=>{:type=>"POST"}, :project=>{:type=>"DELETE"}}>>
end

p Rails.routes # => #<RouteSet:0x00007f8dd216d6d8 @routes={:about=>{:type=>"GET"}, :users=>{:type=>"POST"}, :project=>{:type=>"DELETE"}}>


# _________________________________________________________________________