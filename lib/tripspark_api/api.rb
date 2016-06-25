require 'memoist'

module TripSpark
  # A base class implementing common API operations
  class API
    include Connection

    class << self
      extend Memoist

      # Include another API's functionality via a new method on this API.
      # For example, `include_api :routes` would include the "Routes" API into
      # the "Client" API, accessible as `Client#routes`.
      def include_api name
        klass = self.const_get(name.to_s.constantize)
        define_method(name) do
          klass.new
        end
        self.memoize name
      end

      # Require all the files given in `names` that exist in the given folder
      def require_all folder, *libs
        libs.each do |lib|
          require_relative "#{File.join(folder, lib)}"
        end
      end

      # Return a singleton instance of this API
      def singleton
        @singleton ||= self.new
      end
    end


    # Perform a GET request over the connection to the given endpoint.
    def get_request endpoint, opts={}, &block
      connection.get endpoint, opts, &block
    end

    # Perform a POST request over the connection to the given endpoint.
    def post_request endpoint, opts={}, &block
      connection.post endpoint, opts, &block
    end

    # For APIs that extend Memoist, allow the user to call `refresh` as an
    # alias for `flush_cache`.
    def refresh
      send(:flush_cache) if respond_to?(:flush_cache)
    end
  end
end
