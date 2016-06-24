require 'httparty'
require 'json'

# A Connection adapter using HTTParty as the network transport
module TripSpark
  module Connection
    class HTTPartyAdapter
      include HTTParty

      def initialize config
        self.class.base_uri config.base_uri
        # Write debug information to the configured output stream
        self.class.debug_output config.debug_output
      end

      def get endpoint, opts={}, &block
        JSON.parse(self.class.get(endpoint, opts, &block))
      end

      def post endpoint, opts={}, &block
        JSON.parse(self.class.post(endpoint, opts, &block))
      end
    end

    register_adapter :httparty, HTTPartyAdapter
  end
end
