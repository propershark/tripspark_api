module TripSpark
  class Client::Routes < API
    extend Memoist

    # Return a list of all routes on the system.
    def list
      post_request('/RouteMap/GetRoutes/').map{ |route| Route.new(route) }
    end
    memoize :list
    alias_method :all, :list

    # Return the route whose key matches the given key
    def get key
      list.find{ |route| route.key == key }
    end
    memoize :get
    alias_method :find, :get

    # Return a list of pairs of route keys and direction keys. Used when
    # requesting vehicles.
    def route_direction_pairs *routes
      list.each_with_object([]) do |route, pairs|
        next unless routes.empty? or !routes.include?(route.key)
        route.patterns.each do |pattern|
          pairs << [route.key, pattern.direction.key]
        end
      end.uniq
    end
    memoize :route_direction_pairs
  end
end
