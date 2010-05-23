module MapTP

  # = Namespace for parsers handling the result.
  module Parser

    # Parses the results of a geocoding response.
    module GeocodingResult

      # A hashtable containing the descriptive values
      # for the hierachy property of the response.
      @@hierachy_to_name = {
        1 => "country",
        2 => "state",
        3 => "county",
        4 => "city",
        5 => "district",
        6 => "street",
        7 => "address",
        8 => "zip"
      }

      # Parses the response to a hash
      # and strips all unneccessary data
      def self.to_hash(response)

        resp = response.to_hash

        results = resp[:search_free_response][:map_search_response][:alternatives][:item]

        # Return empty array if no results are returned
        return { :results => [], :ERROR => "No match found" } unless results

        output = Hash.new

        output[:results] = Array.new        

        results.each do |result|

          stripped_result = Hash.new

          major_properties = result[:properties_major][:item]
          #minor_properties = result[:properties_minor][:item]

          address = Hash.new

          major_properties.each do |property|

            address[:name]      = property[:value] if property[:key] == "Name" # only for POIs
            address[:street]    = property[:value] if property[:key] == "Street"
            address[:district]  = property[:value] if property[:key] == "District"
            address[:city]      = property[:value] if property[:key] == "City"
            address[:zip]       = property[:value] if property[:key] == "Zip"
            address[:state]     = property[:value] if property[:key] == "Sta"
            address[:county]    = property[:value] if (property[:key] == "Cty" || property[:key] == "County")
            address[:country]   = property[:value] if (property[:key] == "Ctry" || property[:key] == "Country")

          end          

          stripped_result[:address] = address

          stripped_result[:type] = @@hierachy_to_name[result[:hierarchy].to_i]
          stripped_result[:quality] = result[:quality].downcase

          stripped_result[:coordinate] = {
            :lat => result[:coordinate][:latitude].to_f / 60,
            :lng => result[:coordinate][:longitude].to_f / 60
          }
          
          output[:results] << stripped_result
        end


        output

      end


    end


  end

end