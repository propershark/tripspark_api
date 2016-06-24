module TripSpark
  class Stop < Model
    # The unique key used when referencing this stop
    attribute :key
    # The name of this stop
    attribute :name
    # The position of this stop in the pattern it belongs to
    attribute :rank
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :header_rank
    # The name used to quickly identify this stop
    attribute :stop_code
    # The latitudinal position of this stop
    attribute :latitude
    # The longitudinal position of this stop
    attribute :longitude
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a useless value, e.g. "9999-12-31T23:59:59.9999999".
    attribute :arrival_at_stop
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `0`.
    attribute :time_to_stop
    # Is this stop a time point of the pattern? (A point at which a vehicle
    # wait to remain on schedule)
    attribute :is_time_point
    alias_method :time_point?, :is_time_point
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a useless value, e.g. "0001-01-01T00:00:00".
    attribute :estimated_depart_time
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a useless value, e.g. "0001-01-01T00:00:00".
    attribute :scheduled_work_date
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :schedule_key

    primary_attribute :key
  end
end
