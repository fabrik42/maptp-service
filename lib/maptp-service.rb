require "rubygems"
require "savon"
#require "pp"

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "maptp-service/routing"
require "maptp-service/parser/route"

# = A ruby client for MapTP services.
#
# This gem provides access to the MapTP web services.
#
# In order to use them, you need your MapTP credentials
# aka your Map24 id.
#
# For more information head over to http://www.nn4d.com
#
# *Note*: This is *not* an official client of MapTP or NAVTEQ, but a private project.
#
#

module MapTP
  
  VERSION = '0.0.1'


  def self.set_credentials( map24id, maptp_server )
    @map24_id = map24id
    @maptp_server = maptp_server
  end

  protected

  def self.map24_id
    @map24_id
  end

  def self.maptp_server
    @maptp_server
  end


end