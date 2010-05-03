module MapTP

  # Provides a Ruby client to the SOAP interface of the
  # MapTP routing services.
  #
  # Should be initialized for every new routing request.
  class Routing

    def initialize

      # Disable log output
      Savon::Request.log = false

      @client = Savon::Client.new "http://#{MapTP::maptp_server}.map24.com/map24/webservices1.5?soap=Map24Routing"
    
    end

    # Requests a route description for the given coordinates
    #
    # Parameters:
    #
    # [+start+] A hash containing, longitude and latitude, e.g. { :lng => 123, :lat => 465}
    #
    # [+destination+] A hash containing, longitude and latitude, e.g. { :lng => 123, :lat => 465}
    #
    # Returns either a hash containing the informations or a hash with a key +:ERROR+ containing
    # the error message.
    def find_route_by_coordinates(start, destination)

      begin

        response = @client.calculate_route! do |soap|

          soap.namespaces["xmlns:SOAP-ENV"] = "http://schemas.xmlsoap.org/soap/envelope/"
          soap.namespaces["xmlns:xsd"] = "http://www.w3.org/2001/XMLSchema"
          soap.namespaces["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
          soap.namespaces["xmlns:wsdl"] = "Map24Routing"
          soap.action = 'calculateRoute'
          soap.input = 'calculateRoute'

          soap.body = {

            "RequestHeader" => {
              "Map24ID" => MapTP::map24_id
				
            },
            "CalculateRouteRequest" => {
              "Start" => {
                "Coordinate" => {
                  "Longitude" => start[:lng] * 60,
                  "Latitude" => start[:lat] * 60
                }
						
              },
              "Destination" => {
                "Coordinate" => {
                  "Longitude" => destination[:lng] * 60,
                  "Latitude" => destination[:lat] * 60
                }
              }
              #,"IgnoreDescription" => true
			
            }
	
		
          }
	
        end

        MapTP::Parser::Route.to_hash(response)

      rescue Savon::SOAPFault => e

        { :ERROR => e.message }


      rescue Savon::HTTPError => e

        { :ERROR => "HTTP Error" }

      rescue SocketError

        { :ERROR => "No HTTP Connection" }

      rescue

        { :ERROR => "Unknown Error" }

      end
      
    end

  end
  
end
