require_relative 'lib/tripspark_api/version'

Gem::Specification.new do |spec|
  spec.platform       = Gem::Platform::RUBY
  spec.name           = 'tripspark_api'
  spec.authors        = [ 'Jon Egeland' ]
  spec.email          = 'jonegeland@gmail.com'
  spec.homepage       = 'http://github.com/propershark/tripspark_api'
  spec.summary        = 'Ruby client for TripSpark transit system instances.'
  spec.description    = 'A reverse-engineered Ruby client for the publicly-visible/accessible API that TripSpark transit system instances expose through their network traffic.'
  spec.license        = 'MIT'
  spec.version        = TripSpark::VERSION.dup
  spec.required_ruby_version = '>= 2.2.0'

  spec.files             = Dir['lib/**/*']
  spec.require_paths     = %w[ lib ]
  spec.extra_rdoc_files  = ['LICENSE']

  spec.add_dependency 'httparty', '~> 0.13'
  spec.add_dependency 'memoist',  '~> 0.14'
end
