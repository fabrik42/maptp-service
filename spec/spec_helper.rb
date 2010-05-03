begin
  require 'spec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'maptp-service'

# In order to perform the rspec tests properly
# you have to provide your MapTP credentials.
#
# e.g. if your Map24 id is "123ABC" and bound
# to the server maptp12.map24.com you'll enter
#
# MapTP.set_credentials '123ABC', 'maptp12'

