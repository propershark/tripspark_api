module TripSpark
  class Client::Routes < API
    extend Memoist

    # Return a list of all routes on the system
    def list
      post_request('/GetRoutes/').map{ |route| Route.new(route) }
    end
    memoize :list
    alias_method :all, :list

    # Return the route whose key matches the given key
    def get key
      list.find{ |route| route.key == key }
    end
    alias_method :find, :get
  end
end
