module MapTP

  # = Namespace for parsers handling the result.
  module Parser

    # Parses the results of a calculate route response.
    module Route

      # Parses the response to a hash
      # and strips all unneccessary data
      def self.to_hash(response)

        resp = response.to_hash

        route = resp[:calculate_route_response][:calculate_route_response][:route]

        output = Hash.new

        summary = Hash.new
        summary[:duration] = route[:total_time].to_i
        summary[:distance] = route[:total_length].to_i
        
        output[:summary] = summary

        
        directions = Array.new

        route[:segments][:item].each do |direction|
          
          direction.delete(:type)
          direction.delete(:descriptions)
          direction[:start].delete(:type)
          direction[:start][:lng] = direction[:start][:longitude].to_f / 60
          direction[:start].delete(:longitude)
          direction[:start][:lat] = direction[:start][:latitude].to_f / 60
          direction[:start].delete(:latitude)

          direction[:heading] = direction[:direction][:value].to_i
          direction.delete(:direction)

          if direction[:coordinates]

            direction[:path] = {}
            direction[:path][:lng] = direction[:coordinates][:longitudes].split("|").map { |item| item.to_f / 60 }
            direction[:path][:lat] = direction[:coordinates][:latitudes].split("|").map { |item| item.to_f / 60 }

            direction.delete(:coordinates)

          end

          if direction[:roundabout_exit_number]
            direction[:roundabout_exit_number] = direction[:roundabout_exit_number].to_i
          end

          if direction[:exit_number]
            direction[:exit_number] = direction[:exit_number].to_i
          end
          
          # really?!
          direction.delete(:via)

          direction[:duration] = direction[:time].to_i
          direction.delete(:time)

          direction[:distance] = direction[:segment_length].to_i
          direction.delete(:segment_length)
          

          directions << direction

        end

        output[:directions] = directions
        
        output

      end


    end


  end

end