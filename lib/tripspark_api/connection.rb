module TripSpark
  module Connection
    extend self

    # Return the connection adapter instance
    def connection
      @connection ||= adapter.new(TripSpark.configuration)
    end

    # Return the class of the adapter to use for the connection
    def adapter
      @@adapters[TripSpark.configuration.adapter]
    end

    # Register a new class that can be used as a connection adapter
    def register_adapter name, klass
      (@@adapters ||= {})[name] = klass
    end
  end
end

# Include the adapters that come packaged with the gem
require_relative 'connection_adapters/httparty_adapter.rb'
