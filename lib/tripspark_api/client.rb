require 'memoist'

module TripSpark
  class Client < API
    extend Memoist

    require_all 'client',
      'routes'

    include_api :routes


    # Return a list of patterns for the route given by `route_key`.
    def patterns_for route_key
      post_request('/GetPatternPoints/', body: { routeKey: route_key }).map{ |pattern| Pattern.new(pattern) }
    end
    memoize :patterns_for
  end
end

