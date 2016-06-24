module TripSpark
  class PatternPoint < Model
    # The unique key used when referencing this pattern point
    attribute :key
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :name
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :description
    # The position of this pattern point in the pattern it belongs to
    attribute :rank
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :header_rank
    # The latitudinal position of this pattern point
    attribute :latitude
    # The longitudinal position of this pattern point
    attribute :longitude
    # The type of point that this pattern point represents. Normally either
    # "BusStop" or "WayPoint".
    attribute :point_type_code
    alias_method :type, :point_type_code
    # If this pattern point's type is "BusStop", an instance of `Stop`
    # containing more information about it. Otherwise, nil.
    attribute :stop, type: :stop
    # The key of that pattern that this point belongs to
    attribute :pattern_key
    # Is this pattern point the last point in the pattern it belongs to?
    attribute :is_last_point
    alias_method :last_point?, :is_last_point

    primary_attribute :key
  end
end
