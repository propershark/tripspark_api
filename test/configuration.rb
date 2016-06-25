require_relative '../lib/tripspark_api.rb'

TripSpark.configure do |config|
  config.base_uri     = 'http://bus.gocitybus.com/'
  config.adapter      = :httparty
  config.debug_output = false
end

trip_spark = TripSpark.new

puts trip_spark.vehicles.all.map{ |v| v.name }

v = trip_spark.vehicles.get('a6cdfb13-ab66-41cf-be9d-bb6756a10c1a')
puts "Vehicle #{v.name} is on #{v.route.combined_name} and has #{v.onboard} of #{v.capacity} possible passengers onboard."
