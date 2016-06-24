module TripSpark
  class Client::Patterns < API
    extend Memoist

    # Return a list of all patterns belonging to the given route. Currently,
    # there is no direct way to retrieve all patterns for all routes.
    def list route_key
      params = {
        body: {
          routeKey: route_key
        }
      }
      post_request('/RouteMap/GetPatternPoints/', params).map{ |pattern| Pattern.new(pattern) }
    end
    memoize :list
    alias_method :all, :list

    # Return the route whose key matches the given key
    def get key
      list.find{ |pattern| pattern.key == key }
    end
    memoize :get
    alias_method :find, :get
  end
end
