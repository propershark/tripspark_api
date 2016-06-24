module TripSpark
  class Route < Model
    # The unique key used when referencing this route
    attribute :key
    # The full name of this route
    attribute :name
    # The name used to quickly identify this route
    attribute :short_name
    # A short summary of the purpose of this route
    attribute :description
    # The list of patterns that belong to this route
    attribute :pattern_list, type: :pattern, array: true
    alias_method :patterns, :pattern_list
    # A combination of the name and short_name of this route
    attribute :combined_name
    alias_method :full_name, :combined_name
    # NOTE: The purpose of this field is unknown, as it is almost always given
    # a value of `null`.
    attribute :route_type
    alias_method :type, :route_type

    primary_attribute :key
  end
end
