require_relative '../lib/tripspark_api.rb'

TripSpark.configure do |config|
  config.base_uri     = 'http://bus.gocitybus.com/'
  config.adapter      = :httparty
  config.debug_output = false
end

trip_spark = TripSpark.new

puts trip_spark.vehicles.list.inspect

trip_spark.patterns.list('c765a8d4-ae2e-4066-8365-490dc65539bf').each do |pattern|
  puts "#{pattern.name}: #{pattern.stops.length} stops"
end
