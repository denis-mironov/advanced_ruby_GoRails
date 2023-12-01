# _________________________________________________________________________
# Find common path

require 'pathname' # => library that represents the name of a file or directory on the filesystem, but not the file itself. It is essentially a facade.

def common_paths(paths)
  paths.map { |path| path.ascend.to_a }.reduce(&:&)&.first
end

path_names = [
  Pathname('/usr/bin/ruby'),
  Pathname('/usr/bin/python'),
  Pathname('/usr/bin/go'),
]

p common_paths(path_names) # => #<Pathname:/usr/bin>


# _________________________________________________________________________
# Step by step

# [1,2,3,4].reduce(:+) # => ((((1 + 2) + 3) + 4)

# ascends each path and put the result into array.
p path_names.map { |path| path.ascend.to_a } # =>
# [
#   [
#     #<Pathname:/usr/bin/ruby>,
#     #<Pathname:/usr/bin>,
#     #<Pathname:/usr>,
#     #<Pathname:/>
#   ],
#   [
#     #<Pathname:/usr/bin/python>,
#     #<Pathname:/usr/bin>,
#     #<Pathname:/usr>,
#     #<Pathname:/>
#   ],
#   [
#     #<Pathname:/usr/bin/go>,
#     #<Pathname:/usr/bin>,
#     #<Pathname:/usr>,
#     #<Pathname:/>
#   ]
# ]

# returns similar elements from each array using the '&' for comparison:
# Ex: [1,2,3,4] & [3,4,5,6] => [3,4]
p path_names.map { |path| path.ascend.to_a }.reduce(&:&) # =>
# [#<Pathname:/usr/bin>, #<Pathname:/usr>, #<Pathname:/>]

# Will return the same result as 'reduce' does
p path_names.map { |path| path.ascend.to_a }.inject {|arr, n| arr & n} # =>
# [#<Pathname:/usr/bin>, #<Pathname:/usr>, #<Pathname:/>]

# Checks for nil and returns the first element of the array
p path_names.map { |path| path.ascend.to_a }.reduce(& :&)&.first # => #<Pathname:/usr/bin>

# _________________________________________________________________________