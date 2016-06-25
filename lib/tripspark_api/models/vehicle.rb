module TripSpark
  class Vehicle < Model
    # The unique key used when referencing this vehicle
    attribute :key
    # The name given to this vehicle
    attribute :name
    # The GPS location of this vehicle, along with when it was last updated
    attribute :gps, type: :g_p_s
    # Expose GPS information directly via this vehicle.
    # NOTE: `direction` is delegated here, then aliased as `gps_direction`, and
    # `heading` but `direction` will be not be available like this at run time
    # because it is also the name of a direct attribute of a vehicle, and will
    # get overwritten by that information.
    delegate :latitude, :longitude, :speed, :direction, :last_updated, to: :gps
    alias_method :gps_direction, :direction
    alias_method :heading, :direction
    # The pattern this vehicle is currently traveling
    attribute :pattern, type: :pattern
    # The route this vehicle is currently traveling
    attribute :route, type: :route
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :direction
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :trip_data
    # The next stop that this vehicle will arrive at
    attribute :next_stop, type: :stop
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    # The assumption is that this is a boolean indicating that a passenger has
    # requested the bus stop at the next stop.
    attribute :requested_stop
    # Is this the last vehicle on it's pattern?
    attribute :is_last_vehicle
    alias_method :last_vehicle?, :is_last_vehicle
    # The number of passengers this vehicle can carry at one time
    attribute :passenger_capacity
    alias_method :capacity, :passenger_capacity
    # The number of passengers currently onboard this vehicle
    attribute :passengers_onboard
    alias_method :onboard, :passengers_onboard
    # The saturation of the vehicle with passengers
    attribute :percent_filled
    alias_method :saturation, :percent_filled
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :work

    primary_attribute :key
  end
end
