module TripSpark
  class Client::Vehicles < API
    extend Memoist

    # Return a list of all vehicles currently traveling on routes. If rd_pairs
    # is provided (as an array of route-direction_pairs), only vehicles on
    # those routes will be included.
    def list rd_pairs=nil
      by_pattern(rd_pairs).values.flatten
    end
    memoize :list
    alias_method :all, :list

    # Return a Hash of Pattern objects to vehicles on that pattern. If rd_pairs
    # is provided (as an array of route-direction_pairs), only vehicles on
    # those routes will be included.
    def by_pattern rd_pairs=nil
      params = _route_direction_pair_params(rd_pairs)
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
      def _route_direction_pair_params rd_pairs=nil
        # The information to populate `routeDirectionKeys` for a request is
        # most easily found in `Client::Routes`, if it was not given directly.
        rd_pairs = rd_pairs || Client::Routes.singleton.route_direction_pairs
        rd_pairs.each.with_index.with_object([]) do |((route, dir), idx), params|
          params << "routeDirectionKeys[#{idx}][routeKey]=#{route}"
          params << "routeDirectionKeys[#{idx}][directionKey]=#{dir}"
        end.join('&')
      end
  end
end
