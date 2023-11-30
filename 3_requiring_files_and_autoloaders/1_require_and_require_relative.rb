# _________________________________________________________________________
# require, $LOAD_PATH
# 'require' expects file to be with the .rb extension

p $LOAD_PATH # => array of folders where ruby will look for files to load.
# require 'another' # => cannot load such file -- another (LoadError) -> because it's not in the $LOAD_PATH

# To require a file by name we should add it to the $LOAD_PATH
$LOAD_PATH << '../lib' # => adding lib from the parent directory
$LOAD_PATH << './'     # => adding current directory

require 'file_1'
require 'files_to_require/file_1'

# Without adding a file to the $LOAD_PATH, we can require it by the relative path
require '../lib/file_2'
require './files_to_require/file_2'

# _________________________________________________________________________
# require_relative, current location
# 'require_relative' expects file to be with the .rb extension

# Use 'require' for installed gems / extensions / libs. It uses the $LOAD_PATH to find the files.
# Use 'require_relative' for local files. It does not search in the Ruby load path or gems,
# but only looks for the file in relation to the current file.

require_relative '../lib/file_1'
require_relative 'files_to_require/file_1' # => you don't need to define current directory (./)
require_relative 'files_to_require/file_2'

# _________________________________________________________________________
# File name and location / Special variables

p __FILE__ # => current file name -> "1_require_and_require_relative.rb"
p __dir__  # => current directory absolute path -> "/Users/denis/Work/Study/GoRails/3_requiring_files_and_autoloaders"

# _________________________________________________________________________
