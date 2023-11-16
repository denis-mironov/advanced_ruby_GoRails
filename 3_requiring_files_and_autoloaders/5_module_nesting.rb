# _________________________________________________________________________
# Module Nesting
# Can become really tricky if you define classes and modules with same names in different files and loading them.
class Post
end

module Admin
  class Post
    class Name
    end
  end

  class User
    p Module.nesting # => [Admin::User, Admin]
    p Post # => referencing to Admin::Post
    p ::Post # => referencing to Post outside an Admin scope. Looks at top level
  end
end

class Admin::User
  p Module.nesting # => [Admin::User]
  p Admin::Post # => referencing to Admin::Post
  p ::Post # => referencing to Post outside an Admin scope. Looks at top level
end
# _________________________________________________________________________