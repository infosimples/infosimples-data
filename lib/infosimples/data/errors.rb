module Infosimples::Data

  # This is our base Error class. Rescue `Infosimples::Data::Error` if you want
  # to catch any known exception related to this gem.
  class Error < Exception
  end

  class ArgumentError < Error
  end

  class Timeout < Error
    def initialize
      super('The request was not processed in the expected time')
    end
  end
end
