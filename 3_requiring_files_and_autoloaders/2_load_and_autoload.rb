# _________________________________________________________________________
# LOAD
# Load is used to bring a file into the place where you making the .load call.
# It requires the .rb extension of the file.
# 'require' / ''require_relative loads the file only ones even if you call it many times,
# 'load' loads file everytime you call it.

# authentivation.rb will be loaded twice here
load '../concerns/authentication.rb' # => 'Authentication loaded!'
load '../concerns/authentication.rb' # => 'Authentication loaded!'

# file_1.rb will be loaded only once here
require_relative '../lib/file_1' # => 'Hello from lib/file_1.rb'
require_relative '../lib/file_1' # => Nothing happens

$LOAD_PATH.unshift('../lib')

require 'file_2' # => 'Hello from lib/file_2.rb'
require 'file_2' # => Nothing happens

# _________________________________________________________________________
# AUTOLOAD
# 'Load' loads file immediatly
# 'autoload' (lazy load) delays the load until it actually used.
# You reserving the load and if anyone wants to write a code, that accessing this file - only then it will be loaded.

# you need to define a constant and file name
autoload :Authorization, '../concerns/authorization.rb' # => Nothing happens

# 'autoload' loads file only once
Authorization # => 'Authorization loaded!'
Authorization # => Nothing happens

# _________________________________________________________________________
# require, require_relative, load, autoload usage:

'Use \'require\' when you want to use external gems (uses $LOAD_PATH)'
'Use \'require_relative\' for local files relative to the current working directory'
'Use \'load\' to pick up any changes you made to a file while the program is running'
'Use \'autoload\' to speed up the initialization of your library by lazily loading the modules'
