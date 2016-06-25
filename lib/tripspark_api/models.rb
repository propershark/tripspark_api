require 'set'

module TripSpark
  class Model
    extend Forwardable

    class << self
      # Define a new attribute of the model.
      # If `type` is given, a new instance of `type` will be created whenever
      # this attribute is assigned a value. This allows creation of nested
      # objects from a simple Hash.
      # If `type` is given and `array` is true, the value given to this
      # attribute will be interpreted as an array and a new instance of `type`
      # will be created for each entry in the array
      # It `type` is given, and the value given to this attribute is nil, no
      # new instance of `type` will be created. Instead, the value will remain
      # nil, as an instance of NilClass.
      def attribute name, type: nil, array: false
        attributes << [name, type]
        attr_reader name
        # Use a custom writer method to allow typed attributes to be
        # instantiated properly.
        define_method "#{name}=" do |value|
          # Only do type conversion if the type is specified and the value is
          # not nil.
          if type and !value.nil?
            # Lookup is done on TripSpark to ensure that Model subclasses are
            # searched first, falling back to other types (Numeric, Hash, etc.)
            # if no Model subclass is found.
            klass = TripSpark.const_get(type.to_s.constantize)
            value = array ? value.map{ |v| klass.new(v) } : klass.new(value)
          end
          instance_variable_set("@#{name}", value)
        end
      end

      # The list of attributes defined on the model
      def attributes
        @attributes ||= Set.new
      end

      # The attribute of the model that can be used to uniquely identify an
      # instance from any other. The primary attribute should also be set
      # with `attribute <name>`.
      attr_accessor :identifier
      def primary_attribute name
        @identifier = name
      end

      # Define one or more delegated methods on the model, passing them to the
      # given attribute.
      def delegate *names, to:
        names.each do |name|
          def_delegator to, name
        end
      end
    end

    # Initialize a model instance with any given attributes assigned
    def initialize args={}
      assign(args)
    end

    # Mass assign a group of attributes. Attribute names will be automatically
    # be converted to snake_case for consistency.
    def assign args={}
      args.each do |name, value|
        public_send("#{name.underscore}=", value)
      end
    end

    # The value of the primary attribute on this model
    def identifier
      send(self.class.identifier)
    end

    # Assume that two Model objects are the same if their primary attributes
    # have the same value
    def == o
      identifier == o.identifier
    end
  end
end

# Include all model subclasses
require_relative 'models/direction'
require_relative 'models/gps'
require_relative 'models/route'
require_relative 'models/pattern'
require_relative 'models/pattern_point'
require_relative 'models/stop'
require_relative 'models/vehicle'
