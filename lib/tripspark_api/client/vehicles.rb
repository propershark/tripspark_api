module TripSpark
  class Client::Vehicles < API
    extend Memoist

    # Return a Hash of Pattern objects to Vehicles on that pattern. If `routes`
    # is provided (as an array of route keys), only vehicles on those routes
    # will be included.
    def by_pattern *routes
      params = _route_direction_pair_params(routes)
      routes = post_request('/RouteMap/GetVehicles/', body: params)
      routes.each.with_object({}) do |route, patterns_hash|
        route['VehiclesByPattern'].each do |pat|
          pattern = Pattern.new(pat['Pattern'])
          # Apparently, vehicles can go in multiple directions concurrently,
          # even though that directly conflicts with the idea that vehicles
          # belong to patterns and patterns have one direction.
          # To avoid creating more Vehicle objects that necessary, first clear
          # the Vehicles hash of any duplicates, then create the objects.
          vehicles = pat['Vehicles'].uniq{ |vehicle| vehicle['Key'] }
          patterns_hash[pattern] = vehicles.map{ |vehicle| Vehicle.new(vehicle) }
        end
      end
    end
    memoize :by_pattern

    # Return a list of all vehicles currently traveling on routes. If `routes`
    # is provided (as an array of route keys), only vehicles on those routes
    # will be included.
    def list *routes
      by_pattern(*routes).values.flatten
    end
    memoize :list
    alias_method :all, :list

    # Return a Hash of Route keys to Vehicles. If `route_keys` are given,
    # only those Routes will be included
    def by_route *route_keys
      list(*route_keys).each.with_object({}) do |vehicle, route_hash|
        (route_hash[vehicle.route.key] ||= []) << vehicle
      end
    end
    memoize :by_route

    # Return the vehicle whose key matches the given key
    def get key
      list.find{ |vehicle| vehicle.key == key }
    end
    memoize :get
    alias_method :find, :get


    private
      # Return a parameter string suitable for supplying routeDirectionKeys to
      # a call to /GetVehicles/. If rd_pairs is provided (as an array of route-
      # direction_pairs), onlye those routes will be included.
      def _route_direction_pair_params routes
        # The information to populate `routeDirectionKeys` for a request is
        # most easily found in `Client::Routes`, if it was not given directly.
        rd_pairs = Client::Routes.singleton.route_direction_pairs(*routes)
        rd_pairs.each.with_index.with_object([]) do |((route, dir), idx), params|
          params << "routeDirectionKeys[#{idx}][routeKey]=#{route}"
          params << "routeDirectionKeys[#{idx}][directionKey]=#{dir}"
        end.join('&')
      end
  end
end
