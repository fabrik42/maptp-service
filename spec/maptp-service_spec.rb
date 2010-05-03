require File.dirname(__FILE__) + '/spec_helper.rb'



describe "MapTP" do


before(:each) do


    @start_coordinate = { :lat => 49.945589, :lng => 8.845563 }
    @destination_coordinate = { :lat => 49.936982, :lng => 8.911113 }

    @wrong_start_coordinate = { :lat => 1234657890, :lng => 1234657890 }
    @wrong_destination_coordinate = { :lat => 987654321, :lng => 987654321 }

    @routing = MapTP::Routing.new

  end

  it "should calculate a route and return it as a hash" do

    @route = @routing.find_route_by_coordinates @start_coordinate, @destination_coordinate

    @route.should be_kind_of(Hash)

    #puts @route

  end

  it "should wrong route" do

    @wrong_route = @routing.find_route_by_coordinates @wrong_start_coordinate, @wrong_destination_coordinate

    @wrong_route.should be_kind_of(Hash)

    @wrong_route[:ERROR].should be_instance_of(String)

  end

  
end
