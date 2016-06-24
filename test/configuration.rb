require_relative '../lib/tripspark_api.rb'

TripSpark.configure do |config|
  config.base_uri     = 'http://bus.gocitybus.com/RouteMap/'
  config.adapter      = :httparty
  config.debug_output = false
end

trip_spark = TripSpark.new.routes
trip_spark.list.each do |route|
  puts route
end

puts
puts trip_spark.get('c765a8d4-ae2e-4066-8365-490dc65539bf')
# trip_spark.patterns_for('c765a8d4-ae2e-4066-8365-490dc65539bf').each do |pattern|
# end
