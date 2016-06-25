module TripSpark
  class GPS < Model
    # The time at which this GPS object as updated
    attribute :date
    alias_method :time,         :date
    alias_method :last_updated, :date
    # The latitudinal position of this object
    attribute :lat
    alias_method :latitude, :lat
    # The longitudinal position of this object
    attribute :long
    alias_method :lon,        :long
    alias_method :longitude,  :long
    # The speed at which this object is traveling
    attribute :spd
    alias_method :speed, :spd
    # The direction this object is facing
    attribute :dir
    alias_method :direction,  :dir
    alias_method :heading,    :dir

    # GPS objects are always considered unique, and therefore do not have a
    # primary attribute
  end
end
