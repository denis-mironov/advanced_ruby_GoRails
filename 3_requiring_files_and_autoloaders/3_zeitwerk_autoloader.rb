# _________________________________________________________________________
# Zeitwerk - is an efficient and thread-safe code loader engine for Ruby. Was added in Rails 6.
# Zeitwerk provides the features of code autoloading, eager loading, and reloading.
# https://guides.rubyonrails.org/v6.0/autoloading_and_reloading_constants.html

# ! Zeitwerk is a gem and we can use it in any Ruby application, even without Rails.

require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir('../concerns')
loader.setup

Authorization # => "Authorization loaded!"
ZeitwerkTest # => "This file was loaded"
ZeitwerkTest.new.get_method_data #=> "I'm method data"
# _________________________________________________________________________