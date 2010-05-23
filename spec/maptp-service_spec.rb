require File.dirname(__FILE__) + '/spec_helper.rb'



describe "MapTP" do


before(:each) do


    @start_coordinate = { :lat => 49.945589, :lng => 8.845563 }
    @destination_coordinate = { :lat => 49.936982, :lng => 8.911113 }

    @wrong_start_coordinate = { :lat => 1234657890, :lng => 1234657890 }
    @wrong_destination_coordinate = { :lat => 987654321, :lng => 987654321 }

    @routing = MapTP::Routing.new

    @search_term = "Downing Street 10 London"

    @wrong_search_term = "x12asd85647c asc354asc68ac asc365a4s64a8s4d65hgf4df"

    @geocoding = MapTP::Geocoding.new

  end

  it "should calculate a route and return it as a hash" do

    @route = @routing.find_route_by_coordinates @start_coordinate, @destination_coordinate

    @route.should be_kind_of(Hash)

    #puts @route

  end

  it "should return an error hash when trying to resolve an impossible route" do

    @wrong_route = @routing.find_route_by_coordinates @wrong_start_coordinate, @wrong_destination_coordinate

    @wrong_route.should be_kind_of(Hash)

    @wrong_route[:ERROR].should be_instance_of(String)

  end

  it "should resolve a search term to geocoded adresses and return them as a hash" do

    @address = @geocoding.find_coordinates_by_text(@search_term)

    @address.should be_kind_of(Hash)

    @address[:results].should be_kind_of(Array)

  end

  it "should return an error hash when trying to geocode an impossible search term" do
    
    @wrong_address = @geocoding.find_coordinates_by_text(@wrong_search_term)

    @wrong_address.should be_kind_of(Hash)

    @wrong_address[:ERROR].should be_instance_of(String)
  end
  
end
