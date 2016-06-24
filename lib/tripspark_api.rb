require_relative 'tripspark_api/core_ext/string'

require_relative 'tripspark_api/version'
require_relative 'tripspark_api/configuration'
require_relative 'tripspark_api/connection'
require_relative 'tripspark_api/models'
require_relative 'tripspark_api/api'
require_relative 'tripspark_api/client'

module TripSpark
  class << self
    # Alias for `TripSpark::Client.new`
    def new
      Client.new
    end

    # The current client configuration
    def configuration
      @configuration ||= Configuration.new
    end

    # Allow users to set configuration options via a block. By default, the
    # configuration will be validated after the block returns. This will raise
    # an exception if any required configurations are not provided. This
    # behavior can be skipped by passing `validate: false` as a parameter.
    def configure validate: true
      yield configuration
      configuration.validate! if validate
      configuration
    end
  end
end
