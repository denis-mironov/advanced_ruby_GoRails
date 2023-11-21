p 'Hello from account_history.rb'

module AccountHistory
  require 'active_support'
  require 'active_support/core_ext'

  p 'User account info'

  def registered_at
    Date.current
  end

  def registration_expires_at
    Date.current + 1.year
  end
end
