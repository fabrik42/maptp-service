module MapTP

  # Provides a Ruby client to the SOAP interface of the
  # MapTP geocoding services (version 5.1).
  #
  # Should be initialized for every new geocoding request.
  class Geocoding

    def initialize

      # Disable log output
      Savon::Request.log = false

      @client = Savon::Client.new "http://#{MapTP::maptp_server}.map24.com/map24/webservices1.5?soap=Map24Geocoder51"
    
    end

    # Searches for addresses and their coordinates that match the provided search query.
    #
    # Parameters:
    #
    # [+query+] The search query, e.g. "Times Square, New York", "Zeil Frankfurt", "Downing Street 10 London"
    #
    # [+max_number_of_alternatives+] The max number of alternatives returned by the service (default is 10)
    #
    # [+response_language+] The language the results shoult be localized (if possible, default is "EN" = English)
    #
    # Returns either a hash containing the informations or a hash with a key +:ERROR+ containing
    # the error message.
    def find_coordinates_by_text(query, max_number_of_alternatives = 10, response_language = "EN")

      begin

        response = @client.search_free! do |soap|

          soap.namespaces["xmlns:SOAP-ENV"] = "http://schemas.xmlsoap.org/soap/envelope/"
          soap.namespaces["xmlns:xsd"] = "http://www.w3.org/2001/XMLSchema"
          soap.namespaces["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
          soap.namespaces["xmlns:wsdl"] = "Map24Geocoder51"
          soap.action = 'searchFree'
          soap.input = 'searchFree'

          soap.body = {

            "RequestHeader" => {
              "Map24ID" => MapTP::map24_id
				
            },
            "MapSearchFreeRequest" => {
              "SearchText" => query,
              "MaxNoOfAlternatives" => max_number_of_alternatives,
              "Properties" => {
                "item" =>
                  {
                    "Key" => "Language",
                    "Value"  => response_language,
                  }
              }
            }
	
		
          }
	
        end

        MapTP::Parser::GeocodingResult.to_hash(response)

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
