require 'memoist'

module TripSpark
  class Client < API
    extend Memoist

    require_all 'client',
      'routes',
      'patterns',
      'vehicles'

    include_api :routes
    include_api :patterns
    include_api :vehicles
  end
end

