module TripSpark
  class Pattern < Model
    # The unique key used when referencing this pattern
    attribute :key
    # The full name of this pattern
    attribute :name
    # The name used to quickly identify this pattern
    attribute :short_name
    # A short summary of the purpose of this pattern
    attribute :description
    # The type of line segment that should be used when displaying this pattern
    attribute :line_type
    # The color that should be used to shade this pattern (as a hexcode)
    attribute :line_color
    # Is this a pattern that can be displayed?
    attribute :is_displayable
    alias_method :displayable?, :is_displayable
    # Is this the primary pattern of the route it belongs to?
    attribute :is_primary_pattern
    alias_method :primary_pattern?, :is_primary_pattern
    # The Direction that this pattern heads in
    attribute :direction, type: :direction
    # The list of key points that this pattern touches
    attribute :pattern_point_list, type: :pattern_point, array: true
    alias_method :pattern_points, :pattern_point_list
    alias_method :points,         :pattern_point_list

    primary_attribute :key


    # Return only the pattern points of this pattern that have the type `BusStop`
    def stops
      @stops ||= pattern_point_list.select{ |point| point.type == "BusStop" }
    end

    # Return only the pattern points of this pattern that have the type `WayPoint`
    def waypoints
      @waypoints ||= pattern_point_list.select{ |point| point.type == "WayPoint" }
    end
  end
end
