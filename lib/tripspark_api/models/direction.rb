module TripSpark
  class Direction < Model
    # The unique key used when referencing this direction
    attribute :direction_key
    alias_method :key, :direction_key
    # The name of this direction
    attribute :direction_name
    alias_method :name, :direction_name
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :route_key
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :schedule_key
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :direction_external_id

    primary_attribute :direction_key
  end
end
