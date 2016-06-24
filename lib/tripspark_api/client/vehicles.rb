module TripSpark
  class Client::Vehicles < API
    extend Memoist

    # Return a list of all vehicles currently traveling on routes
    def list
      # The information to populate `routeDirectionKeys` for a request to
      # /GetVehicles/ is most easily found in `Client::Routes.list`
      rd_pairs = Client::Routes.singleton.route_direction_pairs
      params = rd_pairs.map.with_index do |(r, d), i|
        "routeDirectionKeys[#{i}][routeKey]=#{r}&routeDirectionKeys[#{i}][directionKey]=#{d}"
      end.join('&')

      # Why, oh why, is this nesting necessary?
      # Answer: It's not.
      post_request('/GetVehicles/', body: params).each_with_object([]) do |route, vehicles|
        route['VehiclesByPattern'].each do |vehicles_for_pattern|
          vehicles_for_pattern['Vehicles'].each do |vehicle|
            vehicles << Vehicle.new(pattern)
          end
        end
      end
    end
    memoize :list
    alias_method :all, :list

    # Return the vehicle whose key matches the given key
    def get key
      list.find{ |vehicle| vehicle.key == key }
    end
    memoize :get
    alias_method :find, :get
  end
end
