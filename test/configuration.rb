require_relative '../lib/tripspark_api.rb'

TripSpark.configure do |config|
  config.base_uri     = 'http://bus.gocitybus.com/'
  config.adapter      = :httparty
  config.debug_output = false
end

trip_spark = TripSpark.new

# puts trip_spark.vehicles.all.map{ |v| v.name }

# v = trip_spark.vehicles.get('a6cdfb13-ab66-41cf-be9d-bb6756a10c1a')
# puts "Vehicle #{v.name} is on #{v.route.combined_name} and has #{v.onboard} of #{v.capacity} possible passengers onboard."

puts trip_spark.vehicles.by_route.length
trip_spark.vehicles.by_route.each do |route, vehicles|
  puts "#{trip_spark.routes.get(route).name}:"
  vehicles.each{ |v| puts "  #{v.name} (#{v.percent_filled}% filled)" }
end
